Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 902A252576B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 23:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359027AbiELVwv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 17:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358977AbiELVv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 17:51:26 -0400
X-Greylist: delayed 1011 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 12 May 2022 14:51:23 PDT
Received: from mail.mutex.one (mail.mutex.one [62.77.152.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AA7230556;
        Thu, 12 May 2022 14:51:21 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.mutex.one (Postfix) with ESMTP id 008AD16C0067;
        Fri, 13 May 2022 00:34:28 +0300 (EEST)
X-Virus-Scanned: Debian amavisd-new at mail.mutex.one
Received: from mail.mutex.one ([127.0.0.1])
        by localhost (mail.mutex.one [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id SDOVAbhfpF0o; Fri, 13 May 2022 00:34:26 +0300 (EEST)
From:   Marian Postevca <posteuca@mutex.one>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mutex.one; s=default;
        t=1652391266; bh=aak8G0G2h1L0uLPzaC7njJr131nH10XmNxDTv3BtLtQ=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=ELBoTSOMnkxliWHU4oJ1PWOdxoCyp/y6Xg/bBct47eFZPuJukdNfcfiurAkZf6Udm
         G2bLTy5faSVCOFAzf0jToHKcvZLLoNnaHh0KwZUinaTT8aNr750VHeCvbbs+9EVuua
         qfo9r6tEEda01JSsXEvhWhMhDyWMfaFl8I7oQFhs=
To:     Maximilian Senftleben <kernel@mail.msdigital.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: No static MAC address for usb gadget ethernet via
 kernel parameter any more.
In-Reply-To: <dfaa54ab-1b03-7aec-5927-d52a4233e56a@msdigital.de>
References: <dfaa54ab-1b03-7aec-5927-d52a4233e56a@msdigital.de>
Date:   Fri, 13 May 2022 00:34:23 +0300
Message-ID: <87sfpe4eqo.fsf@mutex.one>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Maximilian Senftleben <kernel@mail.msdigital.de> writes:

> [1.] One line summary of the problem:
>
> No static MAC address for usb gadget ethernet via kernel boot parameter 
> any more.
>
> [2.] Full description of the problem/report:
>
> In 5.15. and before we were able to set a static MAC address for the usb 
> gadget ethernet connection using kernel parameters "g_ether.dev_addr" 
> and "g_ether.host_addr".

By taking a quick look I don't see yet how this commit would cause the regression,
but I will take a deeper look.

