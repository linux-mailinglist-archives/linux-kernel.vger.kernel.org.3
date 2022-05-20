Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A46CD52E78D
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 10:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347112AbiETIbo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 04:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347183AbiETIbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 04:31:03 -0400
Received: from sonic314-21.consmr.mail.gq1.yahoo.com (sonic314-21.consmr.mail.gq1.yahoo.com [98.137.69.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4735237A34
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 01:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netscape.net; s=a2048; t=1653035460; bh=WuvwqA1c8r2r+p12+b/hUYdMq9rnRGTuBcxt58to+Ao=; h=Date:Subject:From:To:Cc:References:In-Reply-To:From:Subject:Reply-To; b=HF4w2B3LXxAzsPu0cKlClPAp4lIFCVFZUlM+pPQk/ux+ANH+hXbKsjrMjPSA0fZJ7bFN0k3vBmgockcp65NFWPRjltp/uZX8m6/CHBdr+bCznj5y10gd4DlD8HEzG69uE3tqaVbbHsoRnvclRrccUySMDf9kJ1C9NXsVBlCML8dQT9W9zbLw+22y3mNNGSaq/bL8pBTiaCsZ1FW4aFBOwyR2iMix+qtlmTAh2VK/hzqEyMo/dLfJQtZdgFZQeyxm8X+8RTOo9VhypjdtEObCOc6lZPTBSUTACmWdnQ142+D1X8U3FscLu7nqk75T10eZHlh/FT9c4xcPNXHZtL9fMw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1653035460; bh=O145fJvMYEd44wHYCOcQPm3BRaty1a+efZ4N8LUkQQr=; h=X-Sonic-MF:Date:Subject:From:To:From:Subject; b=KTMMx1J1l42zBLEuD7iEYrVpRZ7tenDIzhJP+FNinhG3SjIyDMVzw5N0pDNVL2N2MQ9pb94qH7dr01GJOCOZcXNtF8TViexLW79zwv6ynfIDVQKFpS6XcgMAsXtYpnghDDtVAALwjd1vB81Lt0374U4JDN08+xNpIlCqrxBcoc75xbCbKUwYizkkDqgLilGxLfiRDz8S0S9Gxn5MU4glFMXNaQAKCF1dwkGi1+k+TdJPi7eidZEKU7fihPGPg7vII2CW9XcWkjQ1lU6CFTr5srzCOHQVtMq9U0EeZOeKGy8AtuFKfsD9VLMOg512Kzby6gny/gOQ4gHLvwbJklvxvw==
X-YMail-OSG: 7CjV_foVM1l0tGFHgoKRE.wnpkoqWeJCUCM8L4Pwg7EBf4yx.s.aoDJ2z8Y4XF5
 nkBd3hXNBdVVi6K__NDC5IxyqplLijiN9NeZ4cFpS.V3YLTiqBnHc6oRK5Z8EqCF41FjbcgasEe_
 .7jTmaDxxxf1seLHTx3CMGqC.uE0FcUfHFCdQ0aFCHAylPQXkQbxVdVLtetzY5jGVyjJjYAwblN1
 vPfLUmFTOFV92.71_ntQfBCwQwxYodrAu9_5r9.7MLVTv3RsXOFhjJzUzjOjuXkVlViS6EWQK39I
 pAOH1zQrv4fDeo.H8kIqXiLaLguNxlaaZ_5BkUXZmDyonaKBi.sYdF2Q8XKolWBpPxBjL8ABwAxz
 dORGC7HOvY3DqgaDeTcW1VX0UNy2rSYcPdOHELAgnsIw.ReQ.6t8Zi38Ww_9v0Y.eIJ.JhBK3F4y
 3AvYhUpNIQ7E4y0_KowaJFdmoLIWOs39S41mUGY04i6hwR2YBSQiTyf1skcbtWjF1o1DGoJiA47p
 tGB643aWqy7swWezv7nWOrH7RgGfwz0QXrfxM_SD651_S7WfPhLprmZ4DJsaKp2huC182n9G5mj2
 J7tDv8s3ODCP_Pam_edh69oKeODvNDb7Wcv9Q4WPDh2ow0MWkSw9Gd_JegWygV6hWYcSVGsyIMrC
 Wul_q8qqQk4r9Um3QQe1X7fiwQzX00qdEhCJN3gRgddGsttY9VmdmLOmGAk8VGRxDNx3EZZvVTom
 k55_gpE8nhH2sQRR4p_qDBVjbfd6tGLNXmeZct5LkVFmiuMbBvTeGbWeJ6beEq6bINfpeuA1s7Vz
 dUw9sJsRt_EVP7jT3WUu.lwEUKXqn8iCY.mH_6LNHYGiCFFh1u_geLafXI7TvrwGd__DIWkfGN0c
 B21Ne4nzqW3mM.zen08WR5bF_h7EkCQKcdGQs7B0_U6psVHys5khnmhSFSkPgLuNt7Mzg81aq_i5
 lEb6CJ7LjZ068w7uni4NWUwKNYJPDEuChGKW9zLeXqUpPxcGtYLksJ38AFZFIYttRsR5isWRdf3V
 PVZDQGlDooMFGmzRHM8Vzxl99v5HLLnuw18gf7b5N9Wfhj_fNjPBDcloD1_sqZ3rhcZQmBP9_Qfj
 aL693WDn0UhR8roOTVIiA8r4v9qdPji4UHbg8G4CvQqeY3DXoyrFh8bJ75dFqvI6tPdjgjULmUnS
 uatpSUT5iyIUuNJZsKUMlrkXPZ01xbMjD37Qlqxlryt5PgONqdq_V.oKu.mHofpNX4Xs3SfbwzVv
 O0TOoGKHDE1LufOSQaSaJkQqei.wo3J4HqrbMCYCIuGkcdq7cOlVLzJZakFZBOBBFcA8KYqKPDNm
 9Jl4vloFJ.L3QWh_4yJvRtbkIZp5HOzayLuZgpb96FqCHsCw4Nj1zkOZ_S2BvjISwUOnSmj7ci1L
 46Led9OyVaAkyuSIr0zWtBA1VqJi_Hgrj.kD3zvG7RATCJGALuaHWtp3qGr3Th74hoZ5P.AFKhiA
 jX7R5smlDei5Eqq2bJH97wSPKzCzvv6QUOi5q2d8PZxHiDiyL6Ln0tKdVhpmrGGpuc.ZKRBiD8Nk
 OH2dAahaCJegaKgkXPsjWp4eoB540liVr0lbyginWNwwuX0o.J4lBvOfFz7JAlLA60DB_mgL5ELJ
 tIdfcySg.Rwa8Wp0nOiNuehVWR18vyOqHc6AQjdUnqFUO11t06w9wVnXk8.KY.InwPEryEvMp5yC
 GkVlRDktIfUiGsrnm8EHJcPr6PFCDJvU0aS.ZZWIeX5YefIp1ia0F8OKBeioS5d0TlIbhaJ1perB
 VC8aEYplBd6nDvIbBgVINPEqP86l8KrhYsaofvY_KFasBr8DgnTzvoQVQrRzWpT8q8pQKIf8DcGF
 kVqA6Oadng9UvGIr4J8ZNFir93IcQFiB5YCQQ7NPseQ6Jz15Cum5De1zuR3xvLk.2GNwjrtfTfWI
 jog8o9t3Hwq595MgPp04QPPyH09YM.m5.vyqLRFjcyz_qRmZr_dXE2DfZslymukJNVGJcr5euLX_
 ExafElfRJQ5PA88fSzYl33h7dRiPCVxt.gj6.sUHE8tfZNgU7dF6fwb1jrrK4hYy85fEDlhsjwPo
 tJTd4wvGHA9eAEs7BX_MGbWtbvv.Bo86PLThrT2VFseqEjtbs487_aIswCgSe1BYROpOoQTVbqmJ
 dUl0qV2u5_EGU5ZMvZYeg_Q2Y7toVdr73hw5cJfn5UFjOyl6kspqzrW0rE0YHIknQdgQ._MTGKhq
 Dgy1f
X-Sonic-MF: <brchuckz@aim.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.gq1.yahoo.com with HTTP; Fri, 20 May 2022 08:31:00 +0000
Received: by hermes--canary-production-bf1-5d4b57496-wjd85 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID b6f8f6a30f469bee93e26cb01475724b;
          Fri, 20 May 2022 08:30:57 +0000 (UTC)
Message-ID: <c5fa3c3f-e602-ed68-d670-d59b93c012a0@netscape.net>
Date:   Fri, 20 May 2022 04:30:55 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 2/2] x86/pat: add functions to query specific cache mode
 availability
Content-Language: en-US
From:   Chuck Zmudzinski <brchuckz@netscape.net>
To:     Jan Beulich <jbeulich@suse.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        xen-devel@lists.xenproject.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, Juergen Gross <jgross@suse.com>
References: <20220503132207.17234-1-jgross@suse.com>
 <20220503132207.17234-3-jgross@suse.com>
 <1d86d8ff-6878-5488-e8c4-cbe8a5e8f624@suse.com>
 <0dcb05d0-108f-6252-e768-f75b393a7f5c@suse.com>
 <77255e5b-12bf-5390-6910-dafbaff18e96@netscape.net>
 <a2e95587-418b-879f-2468-8699a6df4a6a@suse.com>
 <8b1ebea5-7820-69c4-2e2b-9866d55bc180@netscape.net>
In-Reply-To: <8b1ebea5-7820-69c4-2e2b-9866d55bc180@netscape.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.20225 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.aol
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/20/2022 2:59 AM, Chuck Zmudzinski wrote:
> On 5/20/2022 2:05 AM, Jan Beulich wrote:
>> On 20.05.2022 06:43, Chuck Zmudzinski wrote:
>>> On 5/4/22 5:14 AM, Juergen Gross wrote:
>>>> On 04.05.22 10:31, Jan Beulich wrote:
>>>>> On 03.05.2022 15:22, Juergen Gross wrote:
>>>>>
>>>>> ... these uses there are several more. You say nothing on why 
>>>>> those want
>>>>> leaving unaltered. When preparing my earlier patch I did inspect them
>>>>> and came to the conclusion that these all would also better 
>>>>> observe the
>>>>> adjusted behavior (or else I couldn't have left pat_enabled() as the
>>>>> only predicate). In fact, as said in the description of my earlier 
>>>>> patch, in
>>>>> my debugging I did find the use in i915_gem_object_pin_map() to be 
>>>>> the
>>>>> problematic one, which you leave alone.
>>>> Oh, I missed that one, sorry.
>>> That is why your patch would not fix my Haswell unless
>>> it also touches i915_gem_object_pin_map() in
>>> drivers/gpu/drm/i915/gem/i915_gem_pages.c
>>>
>>>> I wanted to be rather defensive in my changes, but I agree at least 
>>>> the
>>>> case in arch_phys_wc_add() might want to be changed, too.
>>> I think your approach needs to be more aggressive so it will fix
>>> all the known false negatives introduced by bdd8b6c98239
>>> such as the one in i915_gem_object_pin_map().
>>>
>>> I looked at Jan's approach and I think it would fix the issue
>>> with my Haswell as long as I don't use the nopat option. I
>>> really don't have a strong opinion on that question, but I
>>> think the nopat option as a Linux kernel option, as opposed
>>> to a hypervisor option, should only affect the kernel, and
>>> if the hypervisor provides the pat feature, then the kernel
>>> should not override that,
>> Hmm, why would the kernel not be allowed to override that? Such
>> an override would affect only the single domain where the
>> kernel runs; other domains could take their own decisions.
>>
>> Also, for the sake of completeness: "nopat" used when running on
>> bare metal has the same bad effect on system boot, so there
>> pretty clearly is an error cleanup issue in the i915 driver. But
>> that's orthogonal, and I expect the maintainers may not even care
>> (but tell us "don't do that then").

Actually I just did a test with the last official Debian kernel
build of Linux 5.16, that is, a kernel before bdd8b6c98239 was
applied. In fact, the nopat option does *not* break the i915 driver
in 5.16. That is, with the nopat option, the i915 driver loads
normally on both the bare metal and on the Xen hypervisor.
That means your presumption (and the presumption of
the author of bdd8b6c98239) that the "nopat" option was
being observed by the i915 driver is incorrect. Setting "nopat"
had no effect on my system with Linux 5.16. So after doing these
tests, I am against the aggressive approach of breaking the i915
driver with the "nopat" option because prior to bdd8b6c98239,
nopat did not break the i915 driver. Why break it now?

Prior to bdd8b6c98239, the i915 driver used
static_cpu_has(X86_FEATURE_PAT) to test for the PAT
feature, and apparently this returns true even if nopat
is set, but the new test, pat_enabled(), returns false on
the Xen hypervisor even if nopat is not set. That is
the only problem I see. The question of nopat should
be irrelevant to the i915 driver.

It was unfortunate that the author of bdd8b6c98239
mentioned nopat in the commit message when in fact
nopat was never intended to be used to break the
i915 driver. The i915 driver should ignore the nopat
option and decide what to do based solely on the
capability of the cpu, firmware, and the compiled
options of the Linux kernel. That is how it behaved
before bdd8b6c98239, and that behavior is what needs
to be restored with a patch.

Chuck
