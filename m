Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CB1F52AB4F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 20:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352419AbiEQS41 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 14:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234727AbiEQSz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 14:55:59 -0400
Received: from mail.mutex.one (mail.mutex.one [62.77.152.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FE87CE23;
        Tue, 17 May 2022 11:55:57 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.mutex.one (Postfix) with ESMTP id BFE1116C00B8;
        Tue, 17 May 2022 21:55:55 +0300 (EEST)
X-Virus-Scanned: Debian amavisd-new at mail.mutex.one
Received: from mail.mutex.one ([127.0.0.1])
        by localhost (mail.mutex.one [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id hspIlhltdJJu; Tue, 17 May 2022 21:55:54 +0300 (EEST)
Date:   Tue, 17 May 2022 18:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mutex.one; s=default;
        t=1652813754; bh=8cuV2SZDjnTbwICdrDXtHr+Liqsv/h3p9RfuDQgFjGE=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=B7bwlVgV+//bcGgkWfRXj5/aiF8gD2H30A3tHwKLU9m7r5lcBcT2zrOLhgIGVKnW+
         gK4tgEfrdO/GizBofgYfyt3KMY1MabL4DwFMzx5prK/VemMPimTuAT1c+Dbb5DvHe3
         6E3T1p+fkWUawToMccceZsILsnK3hDQ0q4KSKZ30=
From:   Marian Postevca <posteuca@mutex.one>
To:     Maximilian Senftleben <kernel@mail.msdigital.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <6c0eb462-3fab-473d-8989-b56e5748e5f7@mutex.one>
In-Reply-To: <dfaa54ab-1b03-7aec-5927-d52a4233e56a@msdigital.de>
References:  <dfaa54ab-1b03-7aec-5927-d52a4233e56a@msdigital.de>
Subject: Re: PROBLEM: No static MAC address for usb gadget ethernet via
 kernel parameter any more.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Correlation-ID: <6c0eb462-3fab-473d-8989-b56e5748e5f7@mutex.one>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


12 May 2022 16:39:02 Maximilian Senftleben <kernel@mail.msdigital.de>:

> [1.] One line summary of the problem:
>
> No static MAC address for usb gadget ethernet via kernel boot parameter any more.
>
> [2.] Full description of the problem/report:
>
> In 5.15. and before we were able to set a static MAC address for the usb gadget ethernet connection using kernel parameters "g_ether.dev_addr" and "g_ether.host_addr".
> Since 5.16. and more concrete after commit 890d5b40908bfd1a79be018d2d297cf9df60f4ee, this is no longer possible, and a random MAC address is assigned.
> (Possible Regression)
>
> [3.] Keywords (i.e., modules, networking, kernel):
> usb, gadget, mac, g_ether
>
> [4.] Kernel information
> [4.1.] Kernel version (from /proc/version):
> Linux version 5.17.4-141174-ge11818a6ec02 (ms@local) (arm-v7a-linux-gnueabihf-gcc (OSELAS.Toolchain-2020.08.0 10-20200822) 10.2.1 20200822, GNU ld (GNU Binutils) 2.35) #14 SMP Thu May 12 13:51:50 CEST 2022
> [4.2.] Kernel .config file:
> -
Could you please send the kernel .config file and kernel command line with which you reproduce this issue?
