Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D85457BE29
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 21:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbiGTTA4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 15:00:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbiGTTAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 15:00:25 -0400
X-Greylist: delayed 774 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 20 Jul 2022 12:00:23 PDT
Received: from mout.web.de (mout.web.de [212.227.17.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EF311A063;
        Wed, 20 Jul 2022 12:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1658343618;
        bh=ycXic/L4j3q0601QJr5L93F+yegqdsVh8Ti5PAvl0Lk=;
        h=X-UI-Sender-Class:Date:To:Cc:References:Subject:From:In-Reply-To;
        b=efjQUCYqfEdx/ZW8gn7Wxh7KoK1xd0TLcDI/w6GNvcZGbB7/kPJssTZyjf0UJ/J3e
         lMf7iW8DztVWo4b7dqailHQLGx7Y/ctWNDk/yVuyp+ZFNmZaTS6XBbqkprVQwDdK78
         h/kBNRgdKY10pvvTdTXJ8rmGeiyIIKGrUC3KT2Xo=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.0.28] ([88.152.8.189]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N6K1b-1nQ1br0jPt-016HXQ; Wed, 20
 Jul 2022 20:47:18 +0200
Message-ID: <87bd06f5-bff2-b10b-ae8b-1963bfe269ea@web.de>
Date:   Wed, 20 Jul 2022 20:47:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
To:     icenowy@aosc.io
Cc:     benjamin.tissoires@redhat.com, djogorchock@gmail.com,
        jikos@kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220415100432.23453-1-icenowy@aosc.io>
Subject: Re: [PATCH] HID: nintendo: deregister home LED when it fails
Content-Language: en-US
From:   Nils Helmig <nils.helmig@web.de>
In-Reply-To: <20220415100432.23453-1-icenowy@aosc.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:p78jTrbMBFwCq13XuboLrH3AhmQOs+a911o58PF/7UYZ9B2hlFg
 xaU571zEISbOGiiuSgSepcsVGKRqtJ9rrAiQvwDoIlJjLiBKdymV59UNhfpA9U3JWkCCY1T
 Tg+ZQ59WExj3c0CYGBsw2G8kjaFIo9bT80j2hqqEvM7C4OIUqltj8HGP9XhA0yeIMYgi2Xl
 rKzOJ98uKyw7NjA/0nGOA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:zYw91Ijtppg=:lOGa82rXHkKMIk2phGOkbL
 iOtPjqGLqYiPnGUn2AA955OPKlk3rvqNH2DTVTwScJ7LS+wnxq/M66OyoL6kvsbrebsKJjLGG
 SyHd7ybCEGhFDHRCEAcg1oPs3aX1Py77MIJLjmPWyAGqj6Yrq2YCU4OQMi3ZXGF90if6qdpcI
 lTE8DDY3XcbFvOSUZYYutn/03VRUNxbTliEwNgehgWLgCcMfEI0DU9meQjR+A6JHFhlIoWdUB
 WCwqs3I5sWCs3noRt9VdUkf8dYv27RaJc362Y9kUZsGfJVEP9LZio8yZtQEGKf8VKYwH1PoNJ
 BQkmDhnLavML+aK+0HXFdEdlgXvQ72rcqd4j/o2+Ss/+iNG6F0h93hkbcbOcxsEB9Rss0h18G
 w3x+2Li36uEf6guML3WWbaNSEubyeKtFrK0h6PEYyrNDjUHimJZgz32LvtKcHj17fb622H/xv
 uTSe6v7oNGPq99X3hviFPHRYUp2P1zhp285ajgcBTkQL8YnMy+Wyp32auiqUBGnHctypdCPX+
 qojcnDy+oxqMm8wddiTDUu8mtYedRSFWqPHe76tlpzw5BGXAWn5nRGos5JrjYSUvlIbh9M/J0
 1VMa22ZOfjm4HKj5kt9DBLeMuTyuRTSYahI8VND7Eorq9EgmBUPyAnVfE/HRNeWO+O6F8qzfP
 +XZx7iNt4T9fNIdwDauxYWGcLqIfjFcdpiQAzDw65KB8s3QFf0+dW/68IqsqObvIrjW1TV/uw
 xiY21wC1Wz9Vie0NvAQyiLw5LkrAMaR3zdcgtbUMh9THKjOxCW9Ey5B255StpFLqgiiGKWJuX
 xaopXQcjkMleNdK9bHXf/le6kQN0xYrkVMXGp4g2UpBHhwn6ss4NM2+TROajhzjOjKu364dfF
 lZY8aPVczDtZiEBeuLP65R0MGWn3mQUYuk7S4T+dDZsrSaTfdvEWBHetl5Et2fp5XspgBLg5z
 LO5vLcA59lLpkxAmAXS+IJZwmzgtkWMYsUU4LtKiniKOCGL56LbFMMEgf4Rl3zZnv/CfyiQZW
 AJfh1RkTW7C+5pmXmuyL8OYjWvF4Q49/SXF7Xhl+im/yP0ZLeg/EuHqpg/MNiNZf0mlEjkgHP
 J2XvD3aAWgXTu+iE/goFkF7VZi2B7mHipIg5Q+D+CGZlUvisG/7UA4aRg==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Any updates on this patch? Would like to see this upstream, so that my
8bitdo pro 2 controller can work in switch mode again.
