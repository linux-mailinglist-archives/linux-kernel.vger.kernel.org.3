Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CC2559263C
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 21:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbiHNTxD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 15:53:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbiHNTw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 15:52:58 -0400
Received: from sonic308-55.consmr.mail.gq1.yahoo.com (sonic308-55.consmr.mail.gq1.yahoo.com [98.137.68.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F21562AD8
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 12:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netscape.net; s=a2048; t=1660506776; bh=4U1+2vNEa2iX7n0yXUSFVausmK7G88BenciQy3XIFtQ=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=JK+WXQB8G14rlC5GWn7OToZegTXFCp/asGbYra6OjwcrMmuUZUKmoLHANvxR6SncxSpfAGG/uwQV2J5JQD9LJwNJ0q6fr75TzixMQWo7zp1yyF/29IHJQpi0F9jYijeHvBOMTFyzYm2ZFxTtr8WsZk4gTOke0bZSn9h3MJwm64VLUhZIDv/DPHZIE54Yr+yj3WqlcdZDb63DEq6mbmhIahATUp9BkvQyMHgLN8AuO0HONwcpa1yJS0ippftjzBgIo/72hbQ+ExnTPP8pgYYAgFQjvKugY8PrFXIMJZhbCCJvVXEljfka25i4zZVZDxMS4MjwH5M1eM7lWxnqASBzzg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1660506776; bh=zbjrxgoM4BNyLW6Aou/pTkYhWV8iZXtDXl/bCJtsJVR=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=npnWbyUzCF0NEASfKYV1s179JREepF1CHNiDm+K5Hut1NbTLaFC9Tp1UilCqhKQIPcEusxPLMmtqMHMCgOI/LBX8UYYOMFc9QvAFkUiugBp8U4E/OPaU3Jr5OEXCfkldiu4Hhnc6YIxXxYKCW4JhYEClSn8hAOr9dRiwnS0cwO8J9NTfJIs5oypek06oygzL1zPlBbLekCxQtgt0e9d4C/sXc7oWOB9EMGL2WAPMOrMvRM+iZtZle5aG/7c5HqEU+q1Z3Q0ZlJxxEl4RxJhxWfEf0gyEeEBW7a6kOnU5Aosu5mSKdwJmhcMDWzsN6VsOzJcp2sfgUGghZNxX8kGxFg==
X-YMail-OSG: yNMXqUMVM1nePv6BwxJvCwftu0wF1tIoR9qI.62_9C_1Kam5FymoNdoBNrhFRwA
 T5IQulTD2cWYWu4KvrJiQDRHWxu_XtlIP6XfVzCXUMz9sXCSQOVAHUQIk6RnU7_XcB26h7hGCHeb
 Krnf3rqnwzkv1PpfnQd3LHwhnYDBHrMCkZrX.H2_UXv38rbItD7jcbmWA3f4doJ4qRdlIzr.mjKw
 AwvvJ5uEEQ4rPcZXnB2NP5qYF20fPrmCeU66PTtc_vHHEXftoaN324wTpwi32Ux1m1XaU4tFPDNd
 ez0PAu5OGpG20U0_APlWVPYeY2eoTEelGuxWfxpjQ7riLIwTbTnIOoIFybCt.3myE9Ly4_U7d6Ps
 AwDGUkro05ysYw5OaHrGsMsCevMQt3VDILoE7gOuX54unj34VUTA0wLbw_8x5qtsK0V3xNjl1dJi
 NwoloH4Ac7PzzlY2VsazEnZvSWIOUIpStiEUjqmEJikL_UfUHf0sDNrSgocLFsiLBRZgatibwXT1
 Bh4qW9QJUBrvEBSsAz9dTWfca4B4DZlEUKqtbB3ABbEZbPhb7oUQ8Bz1qPlMX3IDh8EYmrr4gDnL
 PQYdYaKzJyk09UF47VrhDE.mhHJyBFAuxHvbiB_P.qdb_oO7LwTJIU1hsatwVIA2OOe1.ky7thmo
 tsbOuca3wY5t.1YDCGwGYz9LlTfXASrpJFx167ncsQ1_zlBZMb.taelFpLgnXLKaE.pVneSsdo4c
 SOGZtVXQ4NreYag2BBpi8nnU_QgpCQ2RVL1btz3Y0iZr4WcwtlZ1mkXvTycEPZwWITruF10bTc1M
 P74tOrgj5mDwcNv2.DPZgkNsUHiW1E3J7yl3s.5xpw0xKVfNDIxetlhjirqhQ9bZvT3Zfgosnvzy
 K0WbdlUCdd7MKgRqFZiPY_HY_qD2rz6t4pJj1TZ7HyXmYK8TvN0Y4hzD.69.w.fvvA5oUVQD6LOr
 Ow92n7PxBtRrzSSu_CecgzKEsDBL4mh_FtETL5lMcCwFE0G3xJUnxygSca2CK4R4Rar4GpSZ_0pX
 MYKVV3yid0pIrNGsIm_Gnw.O_mIq8zkfFJgpJyxmqF3vuOyla509EZwMYHzWQmezOEhOB2UoCWtF
 m8s5bgyhhJnJd50zSGEyErn2KbayF3txoyyIZYexepEwnzqp3n.9Mgb94bCQckToBMXYL7uySOuy
 exHK50NBhAiiFDgtjzIcnUXtrVzWXFdp1PEnKbAhNnwUircr7OtXMQwYbZubawF9SPbHurqz42t.
 6trA7nLb32vs8x8KgUkAXQjemCKFV.8bXbb23JcKs_myNfUb1lMrcGhGYCsZKrZ.tjr7HFJ24oSY
 CwZjH12tuRClrwkIGUnqICzRfIHGTYpa4IE3i_Vv8.7yTutOJJmQWQcmQgV55aZAkuI.9ba16o3v
 ZUCmIZih6iDSGWSFVIaIGyHmUH89B_AmCpWWoaT2KgG5FKMtjkhkOkuK.DiYg42LbY7GJq29fLt_
 Hr9IbzNEqCDHk4WnPBfHsBTofB7yhzQvz5IMz3.b3I2ESV9Z4F2.Rhi7zu7BUHUHNuaB1B6AZCJc
 hZUI1lv5roBTa6DHLanFJTT8.uSAhKpnNxWFUD4ZYR9YBeBmqf18kwbxLHhwffcyTybk3RrOdbyi
 ZTxAjhN4B5Vu1rhh3Hqv6op1W7VtDRBULxNHny7UIdy8nR65Fc.RCmAXzEPmtmcNrlwqYJWO3ETT
 CI40y6_ib3N0Z0mzsHmX75AAJlaJY754PAaj0tjLapu3xCwl7aPFQGHVHyxb48jQnREHaCuLEH38
 KlvlIkaD.LpOr6Nly1iHqo1swYqwRR0w8JbU08BG6q0dhXO5g3SDlB8fDPPyBmYmuH.QKAWsW11e
 4lV93CmZQyf1ZRoL0wJHo_ivrZavAWTPZkTupVjQf0Q6A_BRgGQ_EXsziP7Bj.YfCsUZMM0JofK9
 L0TImplpEbB9yvrgUFYT39a3ZxEksbeTrvz0puM7GtQfG0_6ak4GW5qlwn2qv_0YqL4s5plXOXuG
 xLIDXEIfeofftQpPI3_joh2BVsS_axr2W5f_9q0yYiQ5Bh6WnyrKFr6Ry5d8LG1nyiSRwHeSovJN
 .bLSCbjoUmYWdmrz4Q_wvb2Ks_x6ekb5RtP_heGNTNSKsBQOHlvJ7Luwi0HeGY1zQM5iW3GUrOw_
 _mWbWRQA8ySIVyMj..M.Mf6tJPe0pCwbBH04FnVVb79nA5.A4bZNCrudqfoVgjhbKkWZF.JiNpBN
 6ymPfuRptS.d.e39AD64Hbrea7dK8ZgZkxyghbf1_gOU-
X-Sonic-MF: <brchuckz@aim.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.gq1.yahoo.com with HTTP; Sun, 14 Aug 2022 19:52:56 +0000
Received: by hermes--production-bf1-7586675c46-npccb (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID f8b1444eb4a30b89b1cc53889bca83f8;
          Sun, 14 Aug 2022 19:52:52 +0000 (UTC)
Message-ID: <3f4c20dd-99de-9084-5040-7f09d355fdb9@netscape.net>
Date:   Sun, 14 Aug 2022 15:52:47 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH 0/3] x86: make pat and mtrr independent from each other
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Thorsten Leemhuis <regressions@leemhuis.info>, jbeulich@suse.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        regressions@lists.linux.dev, Juergen Gross <jgross@suse.com>,
        xen-devel@lists.xenproject.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20220715142549.25223-1-jgross@suse.com>
 <efbde93b-e280-0e40-798d-dc7bf8ca83cf@leemhuis.info>
 <a0ce2f59-b653-fa8b-a016-1335f05c86ae@netscape.net>
 <32ed59c9-c894-c426-dd27-3602625cf3b1@netscape.net>
 <4688ee9b-1b18-3204-cc93-c6ab2ce9222c@netscape.net>
 <YvjFY1dn2Afg/mFj@kroah.com>
 <22bb6f38-c319-35a1-cf8a-07f78904ecfb@netscape.net>
 <YvjyNdH+X0dwjj+f@kroah.com>
Content-Language: en-US
From:   Chuck Zmudzinski <brchuckz@netscape.net>
In-Reply-To: <YvjyNdH+X0dwjj+f@kroah.com>
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

On 8/14/2022 9:01 AM, Greg KH wrote:
> The To: line had your address in it, so it was sent to you, and again,
> it was not encrypted as you claimed, but rather just signed to verify he
> was the sender.  That's not making anything difficult for anyone, so I
> think you owe him an apology here, especially as you are asking him to
> do work for you.

You misunderstand me completely. I am not here to ask Juergen to do any
work for me, he is the one who volunteered to fix a regression that affects
my computer, so I am interested in what he has to say, and I am on this mailing
list to find out if he, and other Linux developers and maintainers, are the kind
of people I want to have writing the software that runs on my computers.
I don't have to tell you what my decision about that is, but do you really think
I want people who refuse to answer my questions about the software they
are writing for my computers to continue to be the ones I rely on for the
security and stability of my computer systems? If you think I am that stupid,
I suppose you also think I am too stupid to receive an e-mail message that
Juergen tried to send me earlier today. The fact is, Juergen is the only
person I am aware of who has tried and failed to get an e-mail message
delivered to me during the past thirty years since I started using e-mail.
That's quite an accomplishment for Juergen to achieve!

Best regards,

Chuck
