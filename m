Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27D505A89A1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 01:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbiHaXyt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 19:54:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbiHaXyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 19:54:47 -0400
Received: from sonic304-25.consmr.mail.ne1.yahoo.com (sonic304-25.consmr.mail.ne1.yahoo.com [66.163.191.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D65ED1E0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 16:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=att.net; s=s1024; t=1661990083; bh=/H7Jd+oscd+6HYShb/7N8CRp+JcEgiRUQWnOQ7RUjhk=; h=Date:From:Subject:To:References:From:Subject:Reply-To; b=E/jZBr1dNOxytL5JynJVpDMCyzKSnUjR1tOra+GoM6f+NS45Mhd7hrRZIVBNLlj6wce40BbIyDqCd4N4M2g4dkmncOqIEm6znCpnHpnnXpEY3/yNJeKpaE5rk1ns2BE7mCWviu7jBDsJ4dKBI0qie9mWfwtm58MM8vfTK+RTrdE=
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1661990083; bh=xR2FXzo+jTX89D9AgHRIzFz9h9h7MMvKPEaFJr8/GpV=; h=X-Sonic-MF:Date:From:Subject:To:From:Subject; b=jsSMfYIPTcwnS+d10PQJnSL8rFS5NXzHeQx+28s9sCdoVGUpAiCvyH7ZmUNYeN7QoLNwBd79zzkPkojJvytgK6I9Bvno47AcufhUlCB+Dk3kDlKBzS3yGO6CuYuuVcY+Hvr+rGlSf/nkkaWKF55dMllMj6CqcBBD79DC5FtdjVPlpl++JREh+ibp3W4+4BQSnSFNOgvnJOH7YwVcrQE14s3xyifeSVAoMAJTd+6bhM7kczwRVxebgaA5RmWDxUEOmBMopgryZ+4QLaUUgHbdo4OLNV5e0/ezmnBmL6LpKIlqBYMwTZyHjlcfzwPJ5lsCQ99KKoNHY+tc4PBcXTLPCg==
X-YMail-OSG: 4FCJKeAVM1nDk6SuizjrsfA2j501SfaenAUhJUYILR1vIG.94AH4NMamL7hLZur
 R5DPLOg3WPk.jgVClHzebhhumj1OEF12A6n3ehKELi3ivqT9Lu0i6HDSltfZxojZQ_rB5PFcjvsd
 Qa91lc_o0n5EXwsyzemU9uUgiPym4tgH1mH2ihMetM3hg2HZv9y67WcqmTS1SElP4zotzsICsJyy
 db0QmhSqcOJyjNjSeIXJyo7OIhqyfr_BsA_g_HafPS35GdW4UtyjsowgQLpmKb62wLmGNdZI50Or
 HT6r4oQCVjYVESazsGXVfGTwqtQt7E9QLdJswSGB2hmELFptooRDWlAdBmj0OdV3gBsOxnhkX2r.
 L3AJEGT3UNa_nGEQb0ab.G7lbTtMufFJ_FQO9aJ7g_NtckCHUG7sQTJ6kas5dyxMyxPpIljq01bA
 5j8gnINtj0j46bLbCujFD8hr.IUH24F_YK9jSdzGTJCB8Ul.ly7I6trD7VqzXpdZIJQrQ4fp41Ky
 juBxrTzX5LuGaUHwS0N64m_HChPfwBbRiVKBZ0NHH8e9FJKxiHPbQ_XOQ92iSIi2t4LWlshniDLW
 t.X7zCnd9cfKNaGUJTqVJ7YgTZlq9C_j2T2VVK2zMNi4NcTsBR.weZmmx4pjaQJ0hls1tGKfD7oC
 TTMY..Mh2Avm6nBgzU68DWUaVBtrmY3P1sM1K7SgloNtuPoThFerDC74dCZnxuGQ0a7Tu133Cgef
 6hPRGyIpK0m53IeOE61xHEG22Qnq5XHObtgJ_6tZDAcEUonbEjs9jssV7zZ_95GLssgJYOtgpRmF
 OyyVx6M5fUjP3w.uYtEP.ESV.GujwalTuszzHKh.36pxmL8Epth3ff7lWPZ2XMcKqewVsNSXf4_G
 4dUBGlF45sBnwvLB1yoeXLL9oN8vSQ4CXh3OOROOPlXWe3NPMYpScnFkolosOMG7j9B8kGgPzVQa
 hkynaJikLMboAZij01e_4qccavhpi6_EIvrWH1FzWmoxTtKIJhsncG02cmLXAHRigMtPNbnNCYJ1
 yrFNcfDd8TANTm9nIqS.FPC6ixYb8e9M5ynI5MxnRv1hPs1oz8SPT1wyfUBdOBj5LbnQ2iVG94qQ
 UdCn_.FLmzGDc6ew0Ty4B_XTBdlKygWhq5YFZUzOIIQqtA7baivlYjdqw2S1V1jfRmO1mErkfFYu
 ZI_fCKf58uIECeu5wVHoaeKaGHg.FWenMQgSUETAoH1vfEPTuhoHUfI6s1gJJmmCaqghDJIpWzig
 sDzO3uv7xeEkSDSkd7LGgHGNd1bs2mkGQw9xdYj2j0H1jrjaEV4lrRa9ow8lcUEu1TX35rYujsj1
 HTC1vSiWUNYjUgqxIsG6YoEa2IG9mwuTgu2oXhsR9FBBTfJ50BkkFgpbfTHvpGkWLb0CubLCD85D
 YcCRZRsXjBmxKWUne3q574bMUugOhw.8WPUrqDDmsecUBoAKr2BpA5yxTL06QUDiKPi4deioFwaY
 3QP_ne88DeuJ_xzmBpDl5SS5s4gd7LXvnbu4wy3ZejjtdPaf06ujLX1UkdlI0oGAWOyBKHeUmZrS
 Z4cgfwCUJO5OMZvIfowsLQ.06YYagLapZpwx3EAbPoavf4x8Q2l7Oz6szEUjPs.LAT7mq.H9pSnx
 F_IpjE5TOFfV_nCIoLFCkfl89dy2f_xYrIY0SZrQVpEM9XNCTf_.Kh1OuRwv7md.p0nFrmg2yZP6
 7gyGllE5HKeIAZ5GnZogjwYv7vVl1uyDee5eRVcMqZttx_qJs1jCn47_4MF3bq5suRcM1NkOT00b
 yVZXh8iBK.Kh4zsKLsPltMNGEzuaGaLFSSC.05OQ5Uah7VsSYCYGazinje9ZH0rRP1aYZn8ZAMlZ
 CdLR2eH_Lx12g3w9sbG9_IxCIzJDlQwbFgp9XWz75_OtAX7Zj_EHzBzcqpJWRmKOjootpXPxFRCR
 Os.dWZGhNyjpXmsR7ZWNj9x2PH7lkRaPkUWek5gy3GtBdUQTiD9ERZsqJqpunxWILVwHNT_FZIrt
 mDAeg5jdFAALPZ0JfDxGv1eP3.siazPMQ5bvSPah4Ul7CLdu2fSIpVj5HLrGjB._L4ziWmJEF0pg
 r0sLd.e5WKe1y8DYuxarlBZ3kqcE5PFbpegab4Un7AomANc6Uk1oeMnG9QEK4ZUHOkPOx6vFzFXX
 e2BPT.L64nMqpIBZy9Pb4n0gSb3Wh1LM_ShaH1F.Y2T3uYuz6jyYoT6oFNFUBtvy7XcC16pZLQnB
 PvpEW
X-Sonic-MF: <pheonix.sja@att.net>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ne1.yahoo.com with HTTP; Wed, 31 Aug 2022 23:54:43 +0000
Received: by hermes--production-gq1-8697bfdb94-5lhh5 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 5d5faa88fc4e5fa52d90bb1e9cc3acaf;
          Wed, 31 Aug 2022 23:54:39 +0000 (UTC)
Date:   Wed, 31 Aug 2022 19:54:31 -0400
From:   Steven J Abner <pheonix.sja@att.net>
Subject: configuration x86/Kconfig bug? or AMD feature request
To:     linux-kernel@vger.kernel.org
Message-Id: <VQ7IHR.9PMZBSNKURXU1@att.net>
X-Mailer: geary/3.36.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
References: <VQ7IHR.9PMZBSNKURXU1.ref@att.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi
I am tailoring a kernel for AMD 2400g on ASRock B450 using 5.18.12 as 
base.
I found a feature I don't believe I need, and the system seems to work 
just
fine without it. A quick glance at the code seems like I'll be just 
fine, too.
In /drivers/platform/x86/Kconfig:1159  I altered the text to:

config PMC_ATOM
      bool "Intel Atom SOC Power Management Controller Driver"
      default y
      depends on PCI
      select COMMON_CLK

Please have a look and decide if x86 must include this code to function 
properly.
Nothing but being x86 selects this. 'default y' was chosen only because 
forced y before.
Steve

I wish to be personally CC'ed the answers/comments posted to the list
in response to my posting, please. I not part of the list.



