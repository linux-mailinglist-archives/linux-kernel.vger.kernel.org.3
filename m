Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 051B5524E88
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 15:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354562AbiELNo2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 09:44:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354431AbiELNoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 09:44:25 -0400
X-Greylist: delayed 323 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 12 May 2022 06:44:23 PDT
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4B615DE40;
        Thu, 12 May 2022 06:44:23 -0700 (PDT)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4KzXtP5sJsz9scQ;
        Thu, 12 May 2022 15:38:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mail.msdigital.de;
        s=MBO0001; t=1652362736;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=6cZLIKwXMZcfNRh7YQ7kuTKx6Fg9bbjG5TtEQMO/3Gw=;
        b=C80xKZemj5G1+Pde0EHQsE6YZp5IaJh+4smg1LGJbcUw/Ozpp0bJ/U7v+JCnZyvqtg+WxR
        3/Go4zNo1VKPg7wG4SpIrLe1wUIoTVmPT8ZbxQXnrovKs009IiG/egd4qWZYmhGsyrhJ1L
        Yz5mwHArOgzk/MnavelS5jp8R8ILGgQYWx8Eq40SlBkfcj4JXYKREF3lFNFm4h8cZWlsd1
        nJCksm1UdPrNn6yKJVtW/HWqqzGJKIMA0dJlf2sLpL8Tx+HzWSInYMckhDsZ663+BizNOk
        KnoSskY2cPjyi5JrBjdRx+2KsBKcUVyiqrzmC+kLY7U7sjwd1PIPGbHvMFlvAA==
Message-ID: <dfaa54ab-1b03-7aec-5927-d52a4233e56a@msdigital.de>
Date:   Thu, 12 May 2022 15:38:47 +0200
MIME-Version: 1.0
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Language: de-DE
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marian Postevca <posteuca@mutex.one>
From:   Maximilian Senftleben <kernel@mail.msdigital.de>
Subject: PROBLEM: No static MAC address for usb gadget ethernet via kernel
 parameter any more.
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] One line summary of the problem:

No static MAC address for usb gadget ethernet via kernel boot parameter 
any more.

[2.] Full description of the problem/report:

In 5.15. and before we were able to set a static MAC address for the usb 
gadget ethernet connection using kernel parameters "g_ether.dev_addr" 
and "g_ether.host_addr".
Since 5.16. and more concrete after commit 
890d5b40908bfd1a79be018d2d297cf9df60f4ee, this is no longer possible, 
and a random MAC address is assigned.
(Possible Regression)

[3.] Keywords (i.e., modules, networking, kernel):
usb, gadget, mac, g_ether

[4.] Kernel information
[4.1.] Kernel version (from /proc/version):
Linux version 5.17.4-141174-ge11818a6ec02 (ms@local) 
(arm-v7a-linux-gnueabihf-gcc (OSELAS.Toolchain-2020.08.0 10-20200822) 
10.2.1 20200822, GNU ld (GNU Binutils) 2.35) #14 SMP Thu May 12 13:51:50 
CEST 2022
[4.2.] Kernel .config file:
-

[5.] Most recent kernel version which did not have the bug:
5.15

[6.] Output of Oops.. message (if applicable) with symbolic information 
resolved (see Documentation/admin-guide/bug-hunting.rst)
-

[7.] A small shell script or example program which triggers the problem 
(if possible)
-

[8.] Environment
-

[9.] Other notes, patches, fixes, workarounds:

In 5.17.4 reverting said commit 890d5b40908bfd1a79be018d2d297cf9df60f4ee 
did resolve the issue for me.

