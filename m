Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39FBC591D0D
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 00:45:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240140AbiHMWli (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Aug 2022 18:41:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240128AbiHMWlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Aug 2022 18:41:37 -0400
Received: from sonic306-21.consmr.mail.gq1.yahoo.com (sonic306-21.consmr.mail.gq1.yahoo.com [98.137.68.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2DA76E2EC
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 15:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netscape.net; s=a2048; t=1660430495; bh=Op1RFBba7lO0xCqevP/9M9G8wIIEt7tgquGAKYMCRmU=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=VtPf1+cvrSvCQSmXcxxRo9fnrb6TL1ikxcV6XnSAdD/IkDRd7Jy2RedTnfxklUimn7YgNWdWD9AAZS+QcesXmDsdY/jPS/MPwu9lRv82b1NOxLOe/IfQ5PiUNhv1hI7quaAjavUAEU2MKssQdCL+HVb2BE8AuYa58b6OY1jBz7wP3hYhjVxIaCDoB6SmJSyKUPf8RzlAxE4ZVocUS9y9gJKH2n4sdlDMhXpNB7l7NbMgu+et+IovG2y0kn4VrGe4oQcmtAhQk6eBJJ85nj0/0hrMqO8p7w2UsW0AMzbKztgunoTWBzXBCIz095GQfOREVD/XUXnzWUj2dWR1U+p1TA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1660430495; bh=2uM/Lus+iAkE18Yn+Xjw5h9L2R1ibQfDEU/xegsCOU1=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=aWqHgK2/ASkFNTztKD69+1kD1YF122Iu/z6xXPHA4rSlnNiLfJ+OFUBjY5X7LyHZ/aApx3CQfh/IlTey59EmcJtsQ0oK5k3VNcdMiaqWpg3MzzEFFuZSQbsuSRNxKMWhbNrHNtiDvY3woVCVuVcnqHSmIRfgwS6PQcUMW9EHJ5Br1mUcdetPazMIpfv/V6E/iTWshUjSYYmoFm/pWv0xCI+HTadC/ra+vomK9WBtzkJKGZP3S747X1LSod5DQRH8KEo4qT1Wpttr/0scMPVTSEMvBmoB2VlS/IEcFoBC19vn+fZs3WFJKnos9TzUhX4KHg5HG+q738JavwUVrbJD5w==
X-YMail-OSG: d6T7FEcVM1mVMOuFN3_NECZYrcXa2YBxu1vvEc2qW2YOpZ_dj6ZAVsTeUWCXgsg
 Faa6AlhjrsVuay8Y8TJeeQ_ubchEey0vSdo_QoewJCWvigBhBZ6C4nqpEAaj76kZD.CrnEIBzei3
 DnHFz9JCaynrI9A1VD5iNXRtMVxUM_1UENV9yl1qrpSD7zsUWQuZqk6d7hfC2gttrajU3uLgaV69
 lEWsXksZZhFs7wL0scUQULTMcCRNVfSR25W9FnU5A5S._c4drwwKhyvJxfxvc.UICZS8sR_HxvZB
 Zpihr6IMIFAocpm22vN8lKsKaHe14XrxWQA._CZtrfQkza8f5OfHxPS5nR68cm3e2kZlrlFgYk_L
 oqYnl_vFqCiwqzxO7F9PzNjApRop6qcUqyCMrT_W5oHiZqRPfPgzlZuhLKjqlz3VGWR8PQdcR.WE
 Pmo12f53_L1HIBhEuvYsCAOfKa7SWyIM5yrdBFVXGo5HK7O0auiz.ER2SfzrfgjavvBu6HyinKl9
 1Psahm3IvbWMxivLMt_Jj2MEOTQ85zWwpPAiFrLjLsvStXCGx6og963Lk98GNjFr4KB0nr9EBnrV
 .ZrrcuNdOPw64yxNhpTYgUwRl7yeGcrltIv78WuHM6Arr18Pf89_S_3kMEw7oMDFfsfV5DVDhbRC
 hgxqQBaXh09Kfh7izN5BhE.5st8Yi4KZ.Yu2f57wzjJcGFtKkfZT0O8unCGrtc1S1v.OUy7AEX1p
 8mXJtGZ9EfJgL5zXsIFjkLZ8VSSYCdy9B_1I_DBZlppwbKkzvcbcAs6AGtwT05sLNZKWKSMduDqF
 cjO.cl_xMvgyx2DAPAbKY8VQjJvvjfntDSI5hQgQUSoC21.9eQWkKrcpM3gTReVti1u27uGUIvNZ
 J6qsoodZ6RSMwj9MDQHJKgGX6gduRD6ZnIEHQEPVGPdxa9XTzov9NRoD0oK2wXmopSp7NPeD3AMA
 aa8SvgyCafDJmo80ctwMHUHE2Y9QvtM.st5ZQn7WnpWAT0JOv3hIU49grEfHQTlwyycCPPT0xWfe
 6MqJx.CQMLXyILxxI06iFLmFe7iu.AHKt6jn_t0WNGztVsplJ5D3YwUdoYNx2QLuviTX4ixRET6e
 BvvG5KIVmmxXvWnjtkjbUtMJi0MQQsP6i3RP_IfkFnAnpubfwSe9xO_Ix95qSu068i81XDJS2k7D
 C91jEQVwP0Yca4dq79FWJ3d0HbrsQeq_G2NBaXzG54QHLtT81oU26k8u28m7escn7Nrg2t8xN1mR
 IfWM258VRn.pFsplhXFrkh6NYFntKcyXj67tRmGp3ymaCVMxcC4hjtelur1LDTblQeNh4cN3thTs
 dUb4tu6ZTsXwJ8lQYXt8Lrap.wfGz46YLB66KHktOiYLc_oxtjfcSRrXoP8VLh1UZZ3O58cjVGdy
 4MQul5ni51YJHkkqhAleWbrkXnLS.kU70LUgrRF410hfs18Wa834krrg5.kHMr1hpzUcLQ_Af7Bk
 e_7ibEenmxmrbcSMe67DtUL9rrvRXl6pMUCeHV71w91LosXaHLJU8Vok8GGyBKV6nnU6hIJKg7.V
 6kXacsI0xHi3KvKqelit1sTiDfKbo8l4nMxtcf_cMuIGfnR2ohI6gt_Cs.mXzAwGi1lXK80O98UU
 WIy4R2gijneda1SxEFknUTGffd7FVaoBrmCgaz.BF6nFxJI9LGGQDCOCfUBpxdOX7wB142T2pcfI
 3NfG83_8Y4eiPVNgI.Q.pmBYS960U1IMF8c3Ol6zpxgumGLoxKh3bjZKJWlQbe7dw.aZlwGROwaX
 5mOB3sNiJUFJvzXmau1UL10bGPx_lBhWydgFn_Vg7BRoh3Ay0wR3U996MdaEutRJ6u1_iBBPcDNl
 UQaqO_zhVPxEfJ8lMotGQaTlFoCLr..Q89ovR5iRb3A4KNeW49MuoEAD0M1ffTmaB6qzlOEPRLD.
 B7czF3F1hG4rWgXjtjaoAOsmGkr74DKRHhj9fTKgvyZoSd4U4N0TJQYygjqBeCsgnJur9KzHIdyJ
 kXQ0Zt1smCTxKPdigGF8ylUUnjm4anLHEVJN2D3KnyO5.JvBx6Lkr0bBdov0btlwI.jU0.e3da7f
 TCmeJT2qQUXCdlFtH5SsjI2eFHyebRZN8htf9Apx8Hul2BQbqM8YEM6abxTeP.gJozmeKcGqyxUC
 GrjiPGqH5UqldmUvlTYSYCOHBhl4N72KoCx1hZef.QYHH4fIRs.xBSYCTqCer8gzP7IrtuwU6AyF
 BWKQRdW5KL9e5miIRDiNr3BhkLDw-
X-Sonic-MF: <brchuckz@aim.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.gq1.yahoo.com with HTTP; Sat, 13 Aug 2022 22:41:35 +0000
Received: by hermes--production-ne1-6649c47445-zp4l8 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 2311408bfed2e7d8c493523d9e059a17;
          Sat, 13 Aug 2022 22:41:34 +0000 (UTC)
Message-ID: <6e709192-064d-fdfb-8596-6474d891dd7f@netscape.net>
Date:   Sat, 13 Aug 2022 18:41:34 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: PING [PATCH 3/3] x86: decouple pat and mtrr handling
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     Juergen Gross <jgross@suse.com>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Jan Beulich <jbeulich@suse.com>,
        xen-devel@lists.xenproject.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        regressions@lists.linux.dev
References: <20220715142549.25223-1-jgross@suse.com>
 <20220715142549.25223-4-jgross@suse.com> <YtbKf51S4lTaziKm@zn.tnic>
 <d838264a-bcd0-29e2-3b23-5427ee0ee041@netscape.net>
 <YvfdYS81vU66tQSs@zn.tnic>
 <3de36953-9b8a-d040-c8dd-44af1ae2d56d@netscape.net>
 <YvgcIu/Y1GMD5WNo@zn.tnic>
From:   Chuck Zmudzinski <brchuckz@netscape.net>
In-Reply-To: <YvgcIu/Y1GMD5WNo@zn.tnic>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.20531 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.aol
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/13/2022 5:48 PM, Borislav Petkov wrote:
> On Sat, Aug 13, 2022 at 05:40:34PM -0400, Chuck Zmudzinski wrote:
> > I did a search for Juergen Gross on lkml and he is active submitting and
> > reviewing patches during the past few weeks. However, he is ignoring
> > comments on his patch to fix this regression.
>
> Please stop this non-sense and be patient. We will fix this soon. For
> the time being you can use Jan's patch locally.
>

Hello Boris,

I am grateful that you took the time to respond and say it will be fixed soon.
By soon, I presume that means within two weeks as the guidance for
fixing regressions recommends:

https://www.kernel.org/doc/html/latest/process/handling-regressions.html

Quoting from that page: "Try to fix regressions quickly once the culprit has
been identified; fixes for most regressions should be merged within two
weeks, but some need to be resolved within two or three days."

If the regression is not fixed by the end of August, I don't think it would
be "nonsense" for me to send another PING at that time. I also think the
PING I sent earlier today is not "nonsense," given that this regression has been
waiting for a fix for over three months, which is much longer than the
expected time to fix a regression of two weeks.

Best regards,

Chuck
