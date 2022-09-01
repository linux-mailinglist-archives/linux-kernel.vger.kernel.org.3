Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA69F5A9F2E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 20:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234806AbiIAShg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 14:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234217AbiIAShK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 14:37:10 -0400
Received: from sonic306-24.consmr.mail.ne1.yahoo.com (sonic306-24.consmr.mail.ne1.yahoo.com [66.163.189.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8932F13F6F
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 11:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=att.net; s=s1024; t=1662057389; bh=miKz9E/t+j0zfgkfNgkCMzSl7+VSjrFh7pyePOaAuYU=; h=Date:From:Subject:To:References:From:Subject:Reply-To; b=2L7MEymt9g6vzXzZuGiFSxmq9HR6HCEBakQqkJ/u5s4OKS4aNDV/bZNV6SvLgPqLZX+C/6R7iCf8SSs/AmZN3fFS+Hp1dCWSi30EyCie6En9WDak8/nXxAXyTOhdltzWLJZkxxtQXj/cehdlW+n8CkdTqWWSFyMzB8a6jnx89OQ=
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1662057389; bh=IETlV+LsKIjs4oyZzb3fwN2Up+vpOAi7Sv901hW/XbP=; h=X-Sonic-MF:Date:From:Subject:To:From:Subject; b=ivnMnmtV3Pu1QDUctn9BzCVzMm6wHRGEkX0PP/uUDWLInV4aYYS6zflpnxd01ltb3hP8IuNv2oBkCAgqufNe1FcK4nvZ+9kg5NBag9jdWkQNbg9Lh6HJYibNbwmCARAlOIEWjD992in6eQVQJV8jUUjOB6mNTbJZhovzH8PJpEStXJEWUBTCr5FulABkb4KRbAxvbP0QVaPDWn3B49qgvMaCSeqmbcsFZEsGcXWXaIGEA0ayKBHt2eXAUU0uHkpsAmqxTPwmMlYDyJC7fzM7i3mtTt+Urv0IVRg6w/aDxv6k3qvgGrba6dFFBZAoeUnC1/ON+tobIPev9d3hZXxgHQ==
X-YMail-OSG: VbZWa9kVM1nOp9TttpRD18x3F2Vf48fMGI6zD7tMm_gBOawyKsVwh9Khz6XEtu3
 9zNfueDxmIA.X0JxWx_WQdNXZfELUOQj133zYVsIdM0goX..RAGHAQ2eEXb3Cev.g6x2f9i2ENkZ
 ow3rGKCbaq1GZDvTQc6ma8.j8ap6P.funouM09cYMuLBqk3TK8EXqOprtRUAsV0TcBcym18oSJg7
 5nO8FFMSgZMNloQ8fJRvQrgkI9NHEJIyQoUi88xmKhDYQT_RbOLpS8p8_m_2rRq6413zcM5ZfIcK
 dKRByHghN5XcEHPvC5a7GPn8wU_fUSOdme0NJnkFKGP.1I.j4qLUjbPwg8OcvJOWuu8djbnFHCx_
 U6nTrx0wAX5CDeCQS8PLhOFLfJe..VulcldEuz4zGs18_DfeafoihOIwRt9J13UEz__wElNVAyMu
 DK5ficijn1DfTlJmlnn0QQmkRYP_NGRlj7olUC4ZEbRncncJR6gDhLxGFQmzDfyY.oUCO_vGzdVW
 JaGkIFAsDXKIuvUROnOrLvD96JnXXK9PuKT0oukrx1czasVRLEmuGNewe85bY1vijT4mWmQE7.nG
 w0XTcvyWQOj0LEof2TB1giVA9zN12o2_VOE8g6YVEBhDFt_byF63Fkcwa0.SJ.MAokLp0nOcz6Ui
 fbiq8R0NmwhEiCReD3SVIIGhdnppiqDPkqwcPSFInHoyw0AD3oj62XxIrb0LNkQ5rwviQBBSEmIl
 1HLrDXza.KQAHLWnrlttRrti7JlqGqetI6NnrCeMItTB4QaJcfmBQpUNU2KgJ5z_RRn3hRHifhIm
 xW4Q_95EXdmJq6xYfE9SY2NfhY.67Fn44gvwca4Qv7yeYm7sQl8R0nzH_AOWNTgUWT0kyJ2cSZCj
 hL21.NP4w5HUu5NUNYySebYgZc9JtFno_vG.IHzH9HT4UcZsBdufR9vwfxEXfmPKnhBac_VVBNaU
 6ox2MpJ9e0g3Z7IMDyVGiyPy6FTnD33dA3Lh8whwr7WOUunWWsWTpigyg.05l_Kb.aPGvsnO4F8Y
 C3W82AUgUEfD3tK.s5FK9ZX39tkP8zY7LJahU9iJtkCClOl5WrG8HZuq.NkEAZul3HBc7L.x4BLE
 85cmLyZv_9uzZDfKByO._v9f6AKzeyCB75jE.qTU2VpCnJXeUQcLS_NOwEJ7NZIb54kSaZkkdr3X
 Xb7y3F9EDrLW3q9_dv8adSBgLwJab6jdS.ereb6yeIstG4KI36PhTLUUR1VqusJ6hWRW2aJtSbyg
 d7MKqxXL91El6mrPS7nn37OfDT0.aJLx321EzOqNKcZvDS3dWVLeNIuaUKm8nGdwIzDsiJx2_IGU
 TtytFPtAOKxfyjYeGTFwo2skPxe52S8mz2MVoX5LUvFWJNnNOwBZXBzEsWSzVuoNX3Nj_aKxAbuG
 z86Ss40hChBxk3sEXH_yzWvXhufRJGiYnifq3PGfVTlqJYFhDp6OYSi28QVA5TmOpaTv8DQjCFm2
 QW0N4lp4S.cc0Yn_d1x7KfoynWf9nNscn4pBBEWhDZfgW4aL1uSaS1oiXh2IpHQWjvxANs.cpn_7
 x_sNqat02SRi6IGvOYyV7ziYMde_FCwOKl4xqp1RKomhdST4IKv3DLHM0JxnXHkDRVZ4MZ5X1Uin
 87pNWUDI3GmQtcMdR21PQYKy2y5k40vL4GPJizQVHl7dgd1uQnLw4qo4FjYx8VnN8oYeM0jB36Y8
 hNqKFxEgrPiy.DRkZJra3xYA5kWCXK_8fKXXnEXLt93mNpKFLLchQBpKRVBUagUgoZhcWSxsP.5Y
 W.QSeIbGYCkHMfRwCTze2ktv5mnFYqPmFLFMlYohOxCdUw9GlHDOcb.7ABWQP.vVQ.TOSCnSygqF
 6Rfo4QCLgAKN0iPh8m9_Fudo0n40Vt3DVtKxigkN.7Sq8aouz1HCPycNPThmWcSiCATTaOXzHMFZ
 rcWcpqSLTqByrwmNYU933Tu7YcqEX62TaJ4Vw.Pg4iq7A.pFIhwwRmt_CkOhfA5h8G4l4XWPOhCx
 UoLh85rxjngvYv_4El1FjT_Q19YVFO8V4cA.fnNljr2bvV9cfBz_RI2SIpbsmVyra9ZXS10lO85.
 pIkismyOSJA1DobUuMGUKkIhn3vHR7EV_w9FoMG7.QTC4iZ.h8d6bDh5J1FyskhpQCeyaG0Jw3yL
 8vKbe.65_GJZSRneM7Zln6MVDU1NBvOAsoups1vcarRMTEQT6dhCMi.cDRjYFM2HKfcRE7G1M82h
 LInaNqSUDV1gW
X-Sonic-MF: <pheonix.sja@att.net>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Thu, 1 Sep 2022 18:36:29 +0000
Received: by hermes--production-bf1-64b498bbdd-jxpwc (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID d545f606c774c2ebb115064e8fb446f6;
          Thu, 01 Sep 2022 18:36:27 +0000 (UTC)
Date:   Thu, 01 Sep 2022 14:36:20 -0400
From:   Steven J Abner <pheonix.sja@att.net>
Subject: amd iommu configuration
To:     linux-kernel@vger.kernel.org
Message-Id: <KONJHR.T3DS4EBAXDVX1@att.net>
X-Mailer: geary/3.36.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
References: <KONJHR.T3DS4EBAXDVX1.ref@att.net>
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
Building a kernel tailored for AMD 2400g on ASRock B450 using 5.18.12 
as base.
I stumbled across an odd situation and which lacked Kconfig info and 
lead to oddity.
/drivers/iommu/amd/Kconfig states 'config AMD_IOMMU_V2' is 'tristate' 
but unlike many
other tristate configures doesn't mention that module name is 
'iommu_v2.ko' and loading should be done by adding to modules-load.d.

The oddity is that by loading as module is as follows (differences):

builtin iommu_v2 version dmesg:
amdgpu: HMM registered 2048MB device memory
amdgpu: Topology: Add APU node [0x0:0x0]
amdgpu: Topology: Add APU node [0x15dd:0x1002]
AMD-Vi: AMD IOMMUv2 loaded and initialized
kfd kfd: amdgpu: added device 1002:15dd
kfd kfd: amdgpu: Allocated 3969056 bytes on gart
memmap_init_zone_device initialised 524288 pages in 0ms

module not loaded due to missing iommu.conf dmesg:
amdgpu: CRAT table disabled by module option
amdgpu: Topology: Add CPU node
amdgpu: Virtual CRAT table created for CPU
kfd kfd: amdgpu: GC IP 090100 not supported in kfd

module load through iommu.conf dmesg:
amdgpu: CRAT table disabled by module option
amdgpu: Topology: Add CPU node
amdgpu: Virtual CRAT table created for CPU
AMD-Vi: AMD IOMMUv2 loaded and initialized
kfd kfd: amdgpu: GC IP 090100 not supported in kfd

Note, only difference on witk/without iommu.conf is:
AMD-Vi: AMD IOMMUv2 loaded and initialized

So does this mean missing features by not having builtin?
If not, should Kconfig have hint about module and loading?

Steve

I wish to be personally CC'ed the answers/comments posted to the list
in response to my posting, please:) Not a list member.




