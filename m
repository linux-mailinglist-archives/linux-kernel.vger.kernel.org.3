Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78E70595FFC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 18:16:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235542AbiHPQQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 12:16:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231324AbiHPQQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 12:16:44 -0400
Received: from sonic316-54.consmr.mail.gq1.yahoo.com (sonic316-54.consmr.mail.gq1.yahoo.com [98.137.69.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30F927676A
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 09:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netscape.net; s=a2048; t=1660666602; bh=SVFpb7xegGotvuUMr/bQJEt7nllzUEym3/0lYR9WT10=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=FFv7bUZvpnJs2n+O83iqdRkeMAdzw11+D8NUNQHgaUatSqUXZjVO8ctQxSWlkJFB/rWixYrq+Gw7d+5yPr1KbyXRNxikzlz5Iw/4Wc+mstP4hh56CIp32QJv9o0GxOpNgVUdlJM9AoJzSqmHEs3C0qTvyofqOszI4WNLX2/yQ5qnzZxATqK2uxwLZLcpgpu6hBGGz23skrKMKOMr1TVnAAwvYyhByXnpkeo9fCmsH5EvCpzei3psJUmC1L1WZUeDYtyiW9/QJSioN00qttFW4Nrby3wzYAw99NR1fSkNsvI0XdmMybRJNkAat2LGUTF7lSk9nma/P1DOmOrrXuKNxg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1660666602; bh=Tfqvvv7EU3gvthsqcGgyOCwFs+Bx0FIjsQtDmfITapf=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=rbKEwah+2mT7efuKQB1NiCk44Lutpvr07U2rBlSvwf9q0K5vVkNwYnSdk4XrA3FSVDOUZ+Lp17t0IBH/qsFFEdjBTd52ydoDbbH5zP0CilHQJ+y36uPh1Zc7An0oS2V4M2diw70qvPj9ZOD0chYj9JpqCzQNTzX1DGWsS3hU++oUdLrAw4zyE2o+fG1Z90P8RYdzHA3cwlQ4OZbtbGzMEkH5QmB9XcSldlgWLzytYFLN1XieZFNDJ0CYN0MXrnK273dYK9jCKvMVu/jx+Vu7od+OkCKQO8FebyGbyPMyvMKNpROZhU1gKHKaysdN+/sRJr+00EviLfXisE+7M5EyYw==
X-YMail-OSG: 6sjBv.0VM1kJ7aiBXQwq5Iiw4BmNpQWsnMbdt3_6LIEmzlmVk99MPJ22aR_fM7h
 1DpmRWIvVsAXWanKGK8QDMk59hyMeEi4Lksp1qqU9t4dmMpD30eHIXQSxKb98e6wcWJFZADEpHtU
 IaXMw2lc9eklyG_WK0u46dzL9Kk1ImA09a2e8hwX4vXhc9motZTXzxxga9_YwxMnZKkz0ZW0_Tmi
 6KP5QjdzleKsC1e94nhaM8uRqqz2.K5oRvY.oIxlXCOJKUtAvSlH8AF3Q9D0bQqjY6MvPb0Idrx8
 Ui2eRRzwV78KxhxEcPr3QWtQ2bqYo..WMPfSAgrX.iYZEV2GL1cKQzN82y8omwtmH2H7.zvpjeB.
 brWjUt85UnRolA.kEV3yAzi_g6ZhUDP9fEvoXbKtzPtHsqfkxqYPaEyJiwhkUFcB9YJE9gl2owDB
 u0U_bYbFBBfP1FohtbkYqF9u72XljCdHcMEUq43kOtJRlgkqYzhYpzBANMMr4Ab4hg9TIjrGJ9jz
 2gyTZ_zu2_xTUNX2MWHFkMPKMv7GwQL1oJOJ2w7YnF6kqKeI68r4_qICme8NC9AlgK2.5id5LM8U
 Wef4v.4AKz2nLAk0Ccl7I1EYOstPiJ62A_7hyuv8PF.7udh7f32aHhLpYVCFDDUwryB1Yq90Aqjc
 wI670AqlXgIcyHvMLbSM2RbWJXrbJyyj7KUpMtZ_Nr7gLb_d1sik.dPizAlYY_Ruqo_CPAkQMjMk
 .X9oZLKSMzzKVd7Hm6yizyDnyknOR38Ux8N6gMZbq9vyI4uogrdNaC6rDE2o5YfUDixy4KgUD5bo
 Uv4cIbV.F5w..ZiUSIQuo.9hAo9VD6JJtu4Rxfc7ELQuvf_8qAXBu9Zz4f8azXpfLINe99GLViPV
 5_M7yDEGoz4jBE0fHm3CqhW9dKUwUfoaBz1f.GeN54oVIvfG8DavFMipnj9GMA9nfvrzkN2gao3C
 kQL7s8jGTkBir7RSq3xy53uB6_nj1leX69mm.uhma2hiCzuvjgiqLKxoRb54LMFfRqN82QELPwG8
 dNYpMe4pNslTqdcfXxQehToqJHSa1wX8b8Dsa5sT6eQy_E_Iws.6vqo9xI_eJeOQ.2B8wkpzMcpO
 azUGBK.6XQEasDcspuApHknttQZosL_ZqgD5Zdb8z7Q45TfDWKdPGwd30OE0PZYfuZ.n7Ht9sWAm
 Eq6RZqoFq6y.aQZqzhfEoPYR0DZlKTrwk0MlP.EkdWhu.Ic1_Uf0pBHzYm280u4iLf8PeWLh8G.o
 fGNzI3nnTCuqrGZoX5Lrxr.1IetTp601oE1D1.zzXzODemu9RVmHG9EA17RuRT5cVAJD_30EFkwA
 7FQC105U1C1Sfc5BXF1pNHKbM2GnVO8umc9dlQxRV0qPxVIDWLrrIidfPxSBDFm2ahOgw1ruaMig
 HLTNEDlgwzzugGGSy9DqIMtYis9QwoBpJt92pZGvuYMcN9kUAyBx_9mXr58r8Hd0EIua.MSNdpJw
 2UqEc6L6fp_OJrmABECoFkXoTSL8WQUaDsRUG9TZvmpQalMlPfG4R.e1.04w2ho1a_Fi9N6Fpazn
 FfTbfhqg1fzYOtqSn.TwOHbjpgNBFYIafyyg5UrLISlKnL3TXeTR2lekIDq88e58I6b2soJaXhyE
 PsuBSgL1FazNG9kSmak30L0J968oc0frHJG4N3mV4DrpjiX5N0qL2.GjSqgggv0P_axUrZoFgAUa
 MmBi6F9RxdyJSvxGURCaWfdQnDedW2GtAyUCSV49PKebnCEMFoeu9QmnM8.Hg1PVpY0QL1ddHkpI
 z1hlWz4uKGwVcqPuZQYVI4ck3VJpSb4xgjdg7CRJP0OuhUgFIVNR931bBPPtWHtsry89XMwefnhH
 n6ls9uGY0GUwOIJbWbtoQn3BVM6enAAx_pE0szhWi8x_K8tbl4R_CyiEIJaa7wCxIRWvSPOkEBT3
 HrDeNaGTa1dBAUikijqKHvKYjnq9.guzp5PetKDFxJcMeVY0Air34tdqO71h85zJ3KFE.bGFyxVF
 Hb1U34vIUdnty1.Z8WmvvxDCw3jEbHK8Vu1z38S1a_XbGdl_Mqdfbq5KDI9Z97x0yCzmc1q.X3Xx
 LDQATlItZFs17eUtz7444h5zLBgDRczqxcCTSZuWR5W3tLSzkOljcbjbf1m.M5qXpJDndMGJmRZf
 e8tsAD7kYM8WA8s6TkyejciH4jxLmHVNN4VDtWBkumWBkObBebldQAlENVpykzrjN64ntotu1GLw
 UIQs6rhzaqZzWCuk-
X-Sonic-MF: <brchuckz@aim.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.gq1.yahoo.com with HTTP; Tue, 16 Aug 2022 16:16:42 +0000
Received: by hermes--production-ne1-6649c47445-dfpjm (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 0539108f3a14b27640c2679d028594e8;
          Tue, 16 Aug 2022 16:16:40 +0000 (UTC)
Message-ID: <be9d077c-ed4d-d5e3-a134-33afff027af4@netscape.net>
Date:   Tue, 16 Aug 2022 12:16:36 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH 0/3] x86: make pat and mtrr independent from each other
To:     Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     jbeulich@suse.com, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        regressions@lists.linux.dev, xen-devel@lists.xenproject.org,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Juergen Gross <jgross@suse.com>
References: <20220715142549.25223-1-jgross@suse.com>
 <efbde93b-e280-0e40-798d-dc7bf8ca83cf@leemhuis.info>
 <a0ce2f59-b653-fa8b-a016-1335f05c86ae@netscape.net>
 <32ed59c9-c894-c426-dd27-3602625cf3b1@netscape.net>
 <c88ea08c-a9d5-ef6a-333a-db9e00c6da6f@suse.com>
 <bd66b5bc-4d07-d968-f46c-40cf624499a7@netscape.net>
 <a29a66e0-2075-8084-84ad-8bd3e8a9fd4a@netscape.net>
 <a7d10605-87e3-c4bd-4a76-f07a04f5751c@leemhuis.info>
 <8d148826-62a5-95f9-8662-be14f56a6336@netscape.net>
 <6b40ecc3-a2d3-3efd-4a19-2faf737f098b@leemhuis.info>
Content-Language: en-US
From:   Chuck Zmudzinski <brchuckz@netscape.net>
In-Reply-To: <6b40ecc3-a2d3-3efd-4a19-2faf737f098b@leemhuis.info>
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

On 8/16/2022 10:41 AM, Thorsten Leemhuis wrote:
> On 15.08.22 20:17, Chuck Zmudzinski wrote:
> > On 8/15/2022 2:00 PM, Thorsten Leemhuis wrote:
> >
> >> And FWIW: I've seen indicators that a solution to resolve this is
> >> hopefully pretty close now.
> > 
> > That's good to know. But I must ask, can you provide a link to a public
> > discussion that indicates a fix is close?
>
> I just searched for the commit id of the culprit yesterday like this:
> https://lore.kernel.org/all/?q=bdd8b6c982*
>
> Which brought me to this message, which looks like Boris applied a
> slightly(?) modified version of Jan's patch to a branch that afaik is
> regularly pushed to Linus:
> https://lore.kernel.org/all/166055884287.401.612271624942869534.tip-bot2@tip-bot2/
>
> So unless problems show up in linux-next I expect this will land in
> master soon (and a bit later be backported to stable due to the CC
> stable tag).

OK, that's exactly the kind of thing I am looking for. It would be
nice if regzbot could have found that patch in that tree and
display it in the web interface as a notable patch. Currently,
regzbot is only linking to a dead patch that does not even fix
the regression as a notable patch associated with this regression.

If regzbot is not yet smart enough to find it, could you take the
time to manually intervene with a regzbot command so that
patch is displayed as a notable patch for this regression?

>
> > Or do you know a fix is close
> > because of private discussions? That distinction is important to me
> > because open source software is much less useful to me if the solutions
> > to problems are not discussed openly (except, of course, for solutions
> > to security vulnerabilities that are not yet public).
>
> You IMHO are expecting a bit too much here IMHO. Solutions to problems
> in open source software get discussed on various, sometimes private
> channels all the time. Just take conferences for example, where people
> discuss them during talks, meetings, or in one-to-ones over coffee;
> sometimes they are the only way to solve complex problems. But as you
> can see from above link it's not like anybody is trying to sneak things
> into the kernel.
>
> Ciao, Thorsten

Well, as a user of Linux, I would like to see more of those discussions in
the open, especially if they relate directly to a fix of a regression tracked
by regzbot. it would be helpful for me to decide questions such as, does
it make sense for me to keep using the foo project to provide a feature,
or should I switch to project baz that provides the same feature?

In any case, watching what Linus actually chooses to commit into
mainline gives me a pretty good clue about such questions.

Best regards,

Chuck
