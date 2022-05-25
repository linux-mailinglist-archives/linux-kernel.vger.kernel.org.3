Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE74D533558
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 04:32:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243625AbiEYCcP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 22:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235106AbiEYCcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 22:32:11 -0400
Received: from sonic311-22.consmr.mail.sg3.yahoo.com (sonic311-22.consmr.mail.sg3.yahoo.com [106.10.244.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05FB642497
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 19:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com.tw; s=s2048; t=1653445926; bh=VnY5er+1i/iJfFZJ2Cn6HWbwgRK414QB8xauHQLJybI=; h=Date:From:Subject:To:Cc:References:In-Reply-To:From:Subject:Reply-To; b=VF5TJI/YE49qXiPMIUTCR6WuRVybXLLqvXrKLifQnW2zDfFz31l8PEUBYBM2eY/60yP7ijDuOMHmEMSibFHmUW4soFhaCAvW3UiPxVWsJDHjOjZQ29u/nudcsqTsdcFimghoO+1vo6ypdYJGtobNdEbxKmEJd7E3SWAHIy6KoPf3zYuTLaPHm4XdMgkajQQg39BZKfcXfI4rqcZ2Yg1FMQuWF3HZKAck0f98Z2HveHG1aOuImqOpUZ/wMMVyuWoXHRKex8N/ZiPa0YsvYhSozvt6kXxLi9XxmaeWs9ZJ9H9Jex85ZxPbSMZ+m8zLnvg9OKRxL6ahFhDfReUH5VKxIQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1653445926; bh=0jy1MpYxa3weoEKvTIy8gb3B3360rpPyva+btlgjj9w=; h=X-Sonic-MF:Date:From:Subject:To:From:Subject; b=XP5wlAPLCRgcDtP2IMu+vp4xxjxsRMAXjSaDVMviM7IZU2tFjD7FjGqCL5IA3+rNXgUEMTfgPgNT4SuPt06i0eu8Jzat9vq2g55ypCmFlMkQ8hfaMQLPR9sKpKYm7gqapB+Fy6bX6vcRyjZMyL8wYbev3ShBLJa5aXou35U7io/DB4KUA6lAo/aPtZu0Z+lItOjmyVobu+OcHwdZLyrbrdF1iuU3kni8j5hGL6Vp+Tbfp1s3e2C0T53dH5rZWmbWiqCNJQNvPdFZ2R6gmuoN7Vwr+Kj+bgVGm1TgxQJPvwzP4d0V/OtA4DkdKXUjo48A+j2K42PC6W5UGCy/OWQuwA==
X-YMail-OSG: oeKMwLEVM1lwMbVSh7GTrehM_I7CgjLQTRoPSgPC5am6BXMSQp.VPb9v19TCmWB
 TAIk9.59YmxHhNJOETtLhRHEIiIkvBHdHhoFwlCeEnlw.yhKndqgNYDbYYwe5Tm6enBZOqfGW2bT
 NNQa4OKMllW.6CzyIBA3y0.u8pCqzxnpXSZA379JBWglQ1FyCw0nJj53QIGrknK.92JLZhgYHM7Z
 CQX2yY8kVDXLHIkmgHEPM0VtK4WWHFf3FHaMjJB2vsLMo.FfOH6QctsaJSEx0ogAJwtkBng5GpbS
 EMkcq7u.7sQ9L48kYQCEEgFlnNi1ZHYukZM4BC5nj07QeHfVl5x48jeFZ_1HImD0LOBRgzaa0a42
 qCO0BHVr7d1x2T1OPZlWnhep8RYsdZuoNQhNLRiFTLYlCu40HvT6zqK9QaiRjAvF3BVsweeMru3f
 utq.FHYl58_lb8vVz7oia2dBouGtH9wp12B4uZpv.a1zslvF927QxdJxKZRULliD5Z8aQdJdgexx
 27ALXQ1FOqITCDH4PdyRYXXy3N.Ic6qR0SAOjQ2GHldo.S6.9k7HBP6VLZR_.y1YHNSy91cpFcyu
 cWkSHNKSx25zPn6q3GiGFwCJeY3WLLRBiDxJlm.kfHG7eMfZ4r0T_nB3kfB2tHwK9n6EwqpNOHc8
 8XlNKOkKVHQAMKGdGoSt_thA2QteBYSzJcLetkNvnukjTKqQjpj5rSmo4QsvFiLKmfNPOcCdrAnX
 hJ7Jw67dzonXkhXMwIxsMeMrsUjtrRym5pdI5DGWVSFn26qrse5pc4qYHH55fYrlQqD4livffEdd
 ZPwuonvREZVzo8rwPHoln8vkaQ4ZriTs3fT2UyR7Y2zHv76xDhyIF0l6FGl5SQC7DB8m5Rycq3Aa
 HPz7fhKGBCZqtBySi7wCRieq4YaAqiI78HqiUoaGL_67pxEi40uQy_8xZCAZtJysuM0fgic4cfZV
 sY3X3lm8dvgytwq_WvwLSEgLf6cLByCsa4i32CtxL0LtHDITs6icF5h1BSQ90wsvHEuWJGsho0d1
 f7aHm4TGgvLToBs0NKpOT7qPv0qE0e9OJPICRmiFhRhSpQ3DwfDi4i_v6T42V4v5MFSHTN6CFOQg
 .kWBjhFKFr5OS5oPTItVbtpvKUJv_O3lD0jde6ErfCNQuZPSl1_jxl66FD7YGAtqk89uU.XRcC14
 DVVn_xF01eFGVTpAsQVGtJErPTtYJrJnNNnqLOQzcO8STGdTlmE3vuMeaAGifEJgWGt1JyNw4Ll.
 NRJnCly6wXxNRbcu3SCJAxHm4zgDFxhwR6f48ZOmg3U6xC9Vlwb8kWjGtwx9xsfiAUtGGPMIwjs7
 wIiEa4gpFo7l8O0Ejx_S0_47QkKvCZdNYljfsuekImFOE9MwGafB6WJR9DJriCYoeVyUY625fjbM
 UIZoS9OOTELrlN3.hsUouskGF8wgQTquBgj7peQ2v1rbQ_l1EqjIoR1hR71dtcCnz2vdWGzLjrlD
 wMpu_K1QA7RxltjubjRcwYQZ1TvcDrEgW9vTFB.lxladBhxDEA1WOgY2225gkURVMxJ_bPFD6zVE
 S.4N164h3j6Tk901zpJkNLfiIyoVp7kvuLSgxtGYStTVQ55hAgXJMLUPb6XH7y2HuwisHWNyht_b
 UHfk6rhifpv6zkyAadn56eTbeflRotBzmhj.8NAMU7T8Q3SxHflO8K6BAny6FFmqcPhRhgCdW10A
 YuupUCTrHz7BQuGfHg7Ix1ygr8aZtGPLs3EstyVorpCEK5ZJDWiELRPww6e0Wt6srVfmylG7qe4F
 8qIvNxsm1bV4RwW.ZodwBHOaF5CXTfwDR0_fRS0n22OGQqy7T2xr29tLA0VB3qJLFFv8FcrB7F1T
 wH42NE3_0h5VnD.6Jm3.dPDJ_Mw8sZgmX.zrVZroPCOCz3u3aqXaqkuIQrL5LJ880lexsXWNhA0Q
 Pq1hJiMK0Bxeb2vvaxQDxleA3KOMyKG0l.cKbsUezKsspbD5VEVT3WealGqAwEhhP7c16WkMWzSL
 AsQS.F4Xk5NEFHY3i2pRu5bXaiYHdpy3EAAzXMcZadfibbe8KOnuZUKD0N7_bz6oiDGB.y.PyOL6
 vHUsTS0982NzIwnEBERuJ6exI7rJQtT2WWesNtDze3FvIqkYDJ0qZUE1KETHq85TK4zi1BudGIYv
 Cvdb3ZOhIFyBusZU8lV3rpFHYqtRAr9oIWvGltkmY5z.QSqs4vzULlEwMY6RNj2VC93Bahu2PEwq
 fpzXPRATImsPCzeDRvsvIeK3MSd36g6sCMUxWjIukGyU8RlkZYytzievc9NSQSDgm2Pwob_u1I5M
 WJorLC6.Qb_sKQyWgLoaU_PyJ
X-Sonic-MF: <ae40515@yahoo.com.tw>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.sg3.yahoo.com with HTTP; Wed, 25 May 2022 02:32:06 +0000
Received: by hermes--canary-production-sg3-7959d4d9bd-vdvd8 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 9adf84adf3e681998ec4f854c15dbbca;
          Wed, 25 May 2022 02:32:05 +0000 (UTC)
Message-ID: <2054ff7a-b529-3ecd-70ea-5897ac82d0de@yahoo.com.tw>
Date:   Wed, 25 May 2022 10:32:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
From:   Alec Su <ae40515@yahoo.com.tw>
Subject: Re: [PATCH 1/2] arm64: dts: qcom: msm8996-xiaomi-natrium: Add support
 for Xiaomi Mi 5s Plus
To:     kernel test robot <lkp@intel.com>, agross@kernel.org,
        bjorn.andersson@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, sboyd@codeaurora.org
Cc:     kbuild-all@lists.01.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        y.oudjana@protonmail.com
References: <20220519074112.25600-2-ae40515@yahoo.com.tw>
 <202205200926.TE2gqa0N-lkp@intel.com>
Content-Language: en-US
In-Reply-To: <202205200926.TE2gqa0N-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.20225 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/5/20 09:34, kernel test robot wrote:
> Hi Alec,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on robh/for-next]
> [also build test ERROR on v5.18-rc7]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Alec-Su/arm64-dts-qcom-msm8996-xiaomi-natrium-Add-support-for-Xiaomi-Mi-5s-Plus/20220519-164217
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
> config: arm64-randconfig-r022-20220518 (https://download.01.org/0day-ci/archive/20220520/202205200926.TE2gqa0N-lkp@intel.com/config)
> compiler: aarch64-linux-gcc (GCC) 11.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/intel-lab-lkp/linux/commit/b35e1afb49b50a1d68a67f66a3eb6c4259f329fb
>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>         git fetch --no-tags linux-review Alec-Su/arm64-dts-qcom-msm8996-xiaomi-natrium-Add-support-for-Xiaomi-Mi-5s-Plus/20220519-164217
>         git checkout b35e1afb49b50a1d68a67f66a3eb6c4259f329fb
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>>> Error: arch/arm64/boot/dts/qcom/msm8996-xiaomi-natrium.dts:79.1-9 Label or path mss_pil not found
>>> Error: arch/arm64/boot/dts/qcom/msm8996-xiaomi-natrium.dts:106.1-10 Label or path slpi_pil not found
>    FATAL ERROR: Syntax error parsing input tree
> 

The labels mss_pil and slpi_pil are in a patch [1] which is already
existed in linux-next but isn't in mainline yet. It should be fine in
linux-next.

[1] https://lore.kernel.org/all/20210926190555.278589-6-y.oudjana@protonmail.com/

Regards,
Alec
