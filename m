Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79A66591FAF
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 14:08:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231357AbiHNMIo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 08:08:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbiHNMIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 08:08:41 -0400
Received: from sonic308-54.consmr.mail.gq1.yahoo.com (sonic308-54.consmr.mail.gq1.yahoo.com [98.137.68.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D3D019C29
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 05:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netscape.net; s=a2048; t=1660478917; bh=FqYDpk0W/PRCpDPiLkTM2gC2KdTfejvBGpSY4SplYNw=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=TNyh9i6GTxUe9jGu6jXq8FZlOkUUqHz67BAcKRDEEjWvJIGLdbDCnjDJUArkUTiv1KtlCh6zx5dknnpNzVMDJpAEfpK/8dc6Y3qqX05YNDiKo+t7gg9lkCjfD+Pi2FlhHHoE6sb+V5CY6RazKBxxjsIYTCK5wDw4BeJmMiLAb/cmgbUgu2Yc3z75nyj2pF5xMh9SfU8567Zh1ajlFZxTZFT/w3NK69NJShFMaG882m8tKXO3IU20DbmUGQiS2sVB/o67WNWGt3W4hWo6SFzk/+RvpcA5MBn3ivHlo4VMGq0sDY5dacXIfmPpluwNHpc2QsLfQR4uC0BfGATnetODuA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1660478917; bh=mxYY4Fyz6D5/6w7YGR7YkmkRjuywMPeaKHCjpRFARMS=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=BXCGtCEKhAfe8irw0TejGED6zCvMEqdeicATylEmXNeeg9J4Yf3EJQqVVWoD8DE4o+zXJ9vD9Jca64/ZZEZQ/IQiiv3Oqgg+RkJDASNksAsRGWAL7l36EC1TKOAUrsSEs5BN89TfWplWYtc1B+PLS59g5Twyr+fnNqxQy5Da330M2GcIkUDeE8t+3Hz6aYvChemUsVBwyzZUeRPNlsNIwuy4yBzCLgjiWM0BBxmebjare1n/ew0gzbvX4ePT3d8QcHICGbDqumHH6miZSZoYplCrUGu61ta97xk5uHEgVCt8H3k0F5pNYQII9q3crXk3O47wYAt0BZ/IHfKJu3chHw==
X-YMail-OSG: Ll7JD_4VM1mpKxXJD72659d96qA4OFCwIcG_300V2QERIL1B.60NkINpWjQwCi7
 CzUk8tCC6wrNoTJleeOjgO_NHZsdLXRvJwIYWQZgiOUXVsKWxR66.kizxf01HHmaLzABEYcJu3ef
 6h9Hs3loPl94mAehykkXvm1jfC.mIiOBDHmaEfzNn3pw9cn2aqNQLWbZy8sq529GoyWgNncAA_nG
 FAkgO18eRwvr3QhNr7S4.7gcqyM6REghUHarwLjyz6A00ccAZOVwr_g0tJs.r4t6iWCdtXGL5RAa
 m8ctmkCPlIrZrqyPR95vv7IeyslWVTMadwww39kTPnh40T8d9P013ZxaQjbWnq0q7rIQWHT.duC2
 fkDQvOWmSHGvVZjvMDbZbNAu1LTCJ91Kc1_VYaLfLurXULnbJ_czX71VJ7OCoBv5vGtDgkWTtstD
 FhzxI8fWVK_x6M0XWgw4EWHzGvTwcVRplNfx6_ZaOxadv7pyCsEM2cRw8D8odUoLx_NPErW7EB.l
 EEHPnPzwoHKENwONb46dvRIloaS5OztcB_25IlpQxvmbSRAznmRSbywyyFFL1rfUBg_iLyNT_cgJ
 jCWIIXxJJn7mIyS42gDTusqidXvh7laXd0SDcXKF0QB.q4F25Gb5Pk4St_lKS6DHu4MUdC64QUSG
 NDW2JddKBNw4vwntNqkxpKHulx2AwIRBvhhh0mFdmvb8xJLjIiwvXW_uFaZcBiNenYsklmLUPfhn
 ef0dxihEPlxqz0laANMXRwQbgLVlQKf.Vm.A4GDlWRqkiV17V9.g4h07lBEijvPBVWzKmgMPTocJ
 kFZ9JfRd.J8maidTo0DUXlnkMvg0FD3oR2CCUcRdQFTajjI94CJ4QNSHGGn1MAoa0rpvG9JWsSFU
 leHVhnQ_FJhSqzM8YFzfdDdTZKEas5Hk8Id9FLI4NIvmWQWGbVK0SY5xpfkdpmmKvz8DFCGN02Y8
 DsyIIhaUYAS2rblUIp8CTKNBj_ZRtVO1621mghoHjxTuJirhc.bemEIqE1kii.MDmsm0.xYMRnQp
 InXRLLdUvwaNG1gD3uXrk73fWpxP4cJu8N3p4S.GrpK1QBab3.HnNRXROUGCR8yII7YhsJ1adfRi
 ESr44.colB0R_tOGTjHmwUuOV7upFPanKiJnQzZtSQSN.w7hcApglZLN2.aXJfTvmTRk4v_P8B7i
 7bIk4pMRhFonhV1U.t0_p4v6ZFzNZYKJUvJ9.0TKbFPBOt2kpeCBWfynrMYza2f1_dPoOw3EXJut
 D20fG7yQZEg06K5zm.XvxDkDZYe2E47Nr9JPRq5N.qCVgVdTMJP2RuOTOGvWqzoEVLTgAGtj2dTF
 z87wd3rIrevDY8eOI4amOb0wipXtpD_gPU0qSFHiM_rRw.qCV7ZtdsZx_vN4shEpFYrckTUjqSiw
 qgnU1UrdbDcY53TCaHbsmLgqBKri6dHI3rf6ytK7cQ52ficVMkB6eQU183q_Je3KUcjqlw3zwoNU
 6FkB2CRx7kSE3St4jNHwKrAIdGybH5SUrovpWfaUWmRwtDz4CmEBwmpmK1nmC.P_8uV2SxaRkIOS
 0vm9Xcf8AD2b_cVg4TQ46onvY4zvCu98c00aAmm_sjptmg2LNw87gVOjDXamzrA3x40CsSr8z76s
 uYOR0BD7N6DwrKkd2Fu5IS2MXOGqFBe0707ohccxLLV6n4fPf9L0GzyvrdK6I1NsNwlU4aSdAXqN
 WyWSALTI_9CFaFVGwQpyT4p35E5k9.3kZlJtr_UnI_cpOUH6jY44RAnfoOawSqdmzz9Y79TzrqgA
 t4Rv..bsKW1exTdADJBdhV8ypzzKsGchh.6jg277TK0OzM9SOHZdsXEHaMrD0gRVoIzwNrs3zqWR
 C4ddCorFewsEEm_e_oy5lV55TwFA3vx1qZwKvxb95t.7T6pBlDhxfwxSEerANhSe25rWzBFg_3dE
 ibDiebNcxPWEDt61kPpMdgJ0Te2m0QKDTZdLlhfDySC9YuetTpKptmBjM514G7kSto1ZJ9l0ujI1
 xooHboVlU2IstphKsPKNMg.79QcOIl_SIt0xX6ochjQdhMSl29.MbGIoRVIV9E.PRhC4yI89Vv_r
 uWkk4fTZSTtl_5ZVLMYm2ftnU1In34c2KGz2Trnz6CCxyfFLVnKkqiyBBTaq51RU43MLPaVRrkM5
 kUDjOeqg2KgbBoW6laBjZO9FWG3WpM9.RbvVUFHG3tdeT9U7jIDwebfS3BrSi.19uiOADrxaWl6R
 9vIwwJSyddjmHXBhH0pCd.JxDsUdLxDWylQ--
X-Sonic-MF: <brchuckz@aim.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.gq1.yahoo.com with HTTP; Sun, 14 Aug 2022 12:08:37 +0000
Received: by hermes--production-ne1-6649c47445-w4lms (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 4c973f23836126c98ca4bc66de1c044e;
          Sun, 14 Aug 2022 12:08:34 +0000 (UTC)
Message-ID: <22bb6f38-c319-35a1-cf8a-07f78904ecfb@netscape.net>
Date:   Sun, 14 Aug 2022 08:08:30 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH 0/3] x86: make pat and mtrr independent from each other
Content-Language: en-US
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
From:   Chuck Zmudzinski <brchuckz@netscape.net>
In-Reply-To: <YvjFY1dn2Afg/mFj@kroah.com>
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

On 8/14/2022 5:50 AM, Greg KH wrote:
> On Sun, Aug 14, 2022 at 05:19:12AM -0400, Chuck Zmudzinski wrote:
> > Well, that did not take long. Juergen responded with a message,
> > which is encrypted and not delivered to my mailbox because I do not
> > have the PGP keys, presumably to make it difficult for me to continue
> > the discussion and defend myself after I was accused of violating
> > the netiquette rules yesterday by Boris:
>
> The message was signed, not encrypted.  Odd that your email client could
> not read it, perhaps you need to use a different one?
>
> thanks,
>
> greg k-h

It's not that my e-mail client could not read it, there is no evidence it
was ever sent to me. I use aol.com which is administered by Yahoo!. It
did not even appear in the web interface for my e-mail service, so it
was never delivered to my e-mail client, which is Thunderbird. Neither
the Windows nor the Linux client can retrieve a message not delivered
to the Yahoo! servers! I also checked the Junk and Spam folders and it
was not there either. But I received your message and other messages
normally. It is as if the message was sent to everyone else on the To:
and Cc: lists except for me. I think the problem was on the sender's end
or with my e-mail service, Yahoo!, which apparently does not accept signed
messages without some special configuration that I have not done
with Yahoo! yet. I will look into it next week.

Chuck
