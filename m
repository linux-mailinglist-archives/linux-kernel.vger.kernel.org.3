Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 747F858432A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 17:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbiG1PhN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 11:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiG1PhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 11:37:11 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C11C4F685;
        Thu, 28 Jul 2022 08:37:10 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 507C96E2;
        Thu, 28 Jul 2022 15:37:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 507C96E2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1659022630; bh=kgXrwoyyY19kUYKotUDu2m3d7yzX0yEwMfk1LS76L2E=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=lNDF2PwVP17et1HVRMqKc1ERaJDQsDXQvu+UL8TKlIYe5i7zArVvBn4jXhdq1S/5H
         +zZv+Dh/2GX+20EM9Xk43OtjkcOGsv6zRCLxvY1Q6mzo+lxG8wP8Hw9WkxhTH5XFJ1
         mkx/sL2dm0Ib1FXL8BggcnoqsBP7QY9m0iBvaVM8Y0KWLc9/cLkyKI3wSPN/ZgJcS7
         +SAjQhq4H1D1U5oepZppEHISC42+0HhW6AX3yAnO61WK3e/id3U2VDMvmHXqzmFH29
         WWJj3k8QR3uDdpitpU7EzHDeZztOSDXq/wmeX3asDSotbQB0IDjjzD5paBZXEIy6nD
         J42i5vyCqed7g==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Federico Vaga <federico.vaga@vaga.pv.it>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] doc:it_IT: align Italian documentation
In-Reply-To: <647c4d53ee57113a60d8f517eb5d32e8@vaga.pv.it>
References: <20220702210820.13118-1-federico.vaga@vaga.pv.it>
 <647c4d53ee57113a60d8f517eb5d32e8@vaga.pv.it>
Date:   Thu, 28 Jul 2022 09:37:09 -0600
Message-ID: <87tu71b656.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Federico Vaga <federico.vaga@vaga.pv.it> writes:

> Hi Jon,
>
> is there something wrong with this v2 patch? I did not get any feedback.

Hmm...not sure why it fell through the cracks.

I had to resolve one conflict (with the submitting-drivers removal) to
apply it, not a bit deal; it's applied now.  Apologies for the delay.

Thanks,

jon
