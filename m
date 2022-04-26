Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49F6051074C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 20:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352184AbiDZSns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 14:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348587AbiDZSnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 14:43:45 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3333E75E7F
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 11:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1650998433;
        bh=ssfRTceXlVJs1MlVYTiA4LjNvtkTyQG/IyM5gtr3Zug=;
        h=X-UI-Sender-Class:Date:From:To:Subject;
        b=OzP78xWet5tFYntDA/B2wmWYM6GPuRinWVvgGHF9s0uElogaTvg572B9oTUI5gYzn
         cyCrpFOPrxvJxuHMYvi5P74vVYdAu+Z4InepJJ9Y3B1hfGtrSqwSXae7q5qBAOk3Ox
         gsiHwT4e6Ili9y/CSipiT93B1hIOoOpuzn1OLTuI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.100.20] ([46.142.33.51]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MGhuK-1nfWMN0hhS-00DqPY for
 <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 20:40:33 +0200
Message-ID: <bdf6f958-0480-9228-e516-0d76b5d1d777@gmx.de>
Date:   Tue, 26 Apr 2022 20:40:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
From:   Ronald Warsow <rwarsow@gmx.de>
To:     linux-kernel@vger.kernel.org
Content-Language: de-DE
Subject: re: [PATCH 5.17 000/146] 5.17.5-rc1 review
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:x1w1C3/NCVFK6O8OPtNanvBrLbeCVjprm5WXVKmJV8sSm5wUKIo
 tEBd4HryeeSAl9Xot7rnGg96gejPUFQf7LwVKRni3Z4hio4d2JmOPS2KjfB/TDy8RZE/eg4
 8biHXNxY+gZSHxgV6h1tWaSbr1qYKqK9GI6kivtAfor0QCVLq/gKsjt87SoqlXzmUlGhaNK
 ZTZ2RSI1QFvtj70s9Mjwg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:YRwbaihv+xA=:xV8+51VhXaq85s7oXNd8H2
 hM+3lwu4vz+zuadbfrph9yCBn1VI7gmM6a2AibCntxT+bSNPlZKQes+Tc0NdSc5FT/EnhgXyp
 kM1t4CvrFDWOzpf5unTKxccNQ921/3Duh0tC7AtrkwacM8M4AMRoEB/Wzb1t6CvFFfeKT0T+V
 3aDMs/PdK9Vjz26tl6ZmXoRs+vmb4y6ID9sou1ylysZSbD9T5e0YOKtVY8Uz69QjV3vT3CorK
 zm3AdE416c8deS7rR0sC4K+e/UeSdbZEKXkURY1A4MezjL7FiBtDAIiBuEDbwAnVjr1FBCOOY
 l0LCFlHULWOaxtg0+DtfHzejn+3iH4acxzYd+I+P5KSFLdIBL7lAjiagiLLvtIN0KtMRlpHZ0
 CuLMdPb8Zl/wWM0tzAwSJkiYhcsxFuRGffQkGa2rf8ieHYV7PsjDERyPJ+VPGPycyQy1Rm0Sb
 auG6GsjfqK2PF8TmomJPhja9X+TkFSs31No2WrFz3yABuVEfgKz+DzwZSc/12dQDRjnTSu76k
 zw7XBANH6nJefzyqSF1gmVzR/gHTvfocoKQdp2L4xlXOGC9kE6vVRwp2AmESrTiAQdIOu+46K
 6Hk2VZyPFwUX8ZGKhqs03VcNyi2pb7F8kpeDyWPrkC/XI4RvYxJjR+smdvXzRuQSlcUzv5zkz
 JYioW2Vmum2+w2xr8G0tLUkXMmc8220/jobxB9rrIw3UClorll/hltWWzMihUnudAz+RmCY2X
 1meGp+QLXQnDgGJjadyLfngCJwnEQLqwwEqyvRkS+xCisKP/yaVnECr1Ec6EhA2PwBb317I2p
 jz5Ut79zpVTZ8T/stFIyQ1uxwDO7WeomQB9VokjxH+7s8KnwqgGrCUTDdd8zT6xg7VYr1j6cR
 SXRuAMD1VT29Zn+Qhe7o1etY1jBIBqwHY6k4BczWb494YZPeUiZu7Hw9UxuI7XogtLX4HSkjx
 4dN7gweoe1nnlqxyyA4F62Br4y/nOl0VrCBVulhLWXTFlxUPAdKMmIFNR1xGD4G/pMrpzwImg
 Ii/paQNYcujRgWPwau0JEXuoHQS3W8baN5+4b3j9k3FPIkdAniWOqzVbY601DXsZT6YSxGmLI
 BKHZTCgR7H/ZE0=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hallo Greg

5.17.5-rc1

compiles, boots and runs here on x86_64
(Intel i5-11400, Fedora 36 Beta)

Thanks

Tested-by: Ronald Warsow <rwarsow@gmx.de


Ronald

