Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 159E35A120A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 15:28:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241363AbiHYN13 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 09:27:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242550AbiHYN1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 09:27:24 -0400
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 25 Aug 2022 06:27:21 PDT
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73E9BABF30
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 06:27:21 -0700 (PDT)
X-KPN-MessageId: 4543126a-2479-11ed-888a-005056992ed3
Received: from smtp.kpnmail.nl (unknown [10.31.155.8])
        by ewsoutbound.so.kpn.org (Halon) with ESMTPS
        id 4543126a-2479-11ed-888a-005056992ed3;
        Thu, 25 Aug 2022 15:24:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=xs4all.nl; s=xs4all01;
        h=content-type:from:to:subject:mime-version:date:message-id;
        bh=+voNQuKrELAJa5qmbG52JO0+X76KIdwoInllqK3/79Y=;
        b=juoJzrbWBY8WBt6aD7USacHQZ4k2jkFsZbCw61fROFRm2cN9R6MBbuF9h9xmH0BGsL7DdQEtNc7fR
         fTABYpLsf74VFUGjX1lz0DIj2Mh+bAkN56itr5sewhqrtXqPTJK/klFNOQozimRm885dbv3ZQ7RPJm
         HN2fjSR1BG4XB6uno39BUcyivLZ67vHoSXiHH4sCesoyYvyjUYFqoDbv8ucFCveNuhNUc+CO1rRLOB
         PCwsVX13Mb39OhdZxCsPYzTDwoO4ksWtlvRzF+fvQjY5voWPLZoYZ8ujLTPP8iBeeh73+ZrH6MOyTB
         KNnL0SqvPc7yqGuCfmi6SQdP63CzEYg==
X-KPN-MID: 33|+DdzbAmxdILoycYAjAPDVFN4xyTAzIxKBrduREbz+9N4ficW+F4q7rSQpQve7QD
 x2oj5Vtyfw0yIfnsNKf8cKg==
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|VPBGdMc3ITf4PWsWF4HAlRdnxadipkEhyluHR9Qj9mED/H6PEHL5iETDdOcM00V
 4j32p1+vm5j8noQpkpJ/ZZw==
X-Originating-IP: 173.38.220.39
Received: from [10.47.77.219] (unknown [173.38.220.39])
        by smtp.xs4all.nl (Halon) with ESMTPSA
        id 7e278ddc-2479-11ed-9b28-00505699d6e5;
        Thu, 25 Aug 2022 15:26:16 +0200 (CEST)
Message-ID: <550291dd-50fe-e09e-071a-73174596aa24@xs4all.nl>
Date:   Thu, 25 Aug 2022 15:26:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH v28 0/4] media: mediatek: support mdp3 on mt8183 platform
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        moudy ho <moudy.ho@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Rob Landley <rob@landley.net>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Alexandre Courbot <acourbot@chromium.org>, tfiga@chromium.org,
        drinkcat@chromium.org, pihsun@chromium.org, hsinyi@google.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        cellopoint.kai@gmail.com
References: <20220823023803.27850-1-moudy.ho@mediatek.com>
 <0237d2e2-f753-6a7d-18fd-67b5fd7df99f@gmail.com>
 <95b08fec052c55a673398e62a7df7f6741f663c8.camel@mediatek.com>
 <b0b5194609a4ed4e62e06fcbe455bcc578987191.camel@mediatek.com>
 <3b14b0c6-e360-3a09-3fd1-29f36e1574a6@gmail.com>
Content-Language: en-US
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <3b14b0c6-e360-3a09-3fd1-29f36e1574a6@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

On 8/25/22 15:07, Matthias Brugger wrote:
> 
> 
> On 25/08/2022 04:41, moudy ho wrote:
>> Hi Matthias,
>>
>> As a friendly reminder, I found out that patches 1 and 2 are already on
>> the Hans's git, hopefully it won't cause you any trouble dealing with
>> this series
>>
> 
> Thanks for the heads-up I removed them from my tree now.

Thank you, I'll merge them via the media tree. Traditionally media bindings
go through our tree together with the drivers.

Regards,

	Hans

> 
> Regards,
> Matthias
> 
>> Regards,
>> Moudy
>>
>> On Thu, 2022-08-25 at 10:06 +0800, moudy ho wrote:
>>> On Wed, 2022-08-24 at 13:32 +0200, Matthias Brugger wrote:
>>>> Patches 1, 2 and 3 now applied to v6.0-next/dts64
>>>>
>>>> Thanks!
>>>> Matthias
>>>>
>>>
>>> Hi Matthias,
>>>
>>> Thanks for your kind assistance.
>>>
>>> Respectfully,
>>> Moudy
>>>
>>>> On 23/08/2022 04:37, Moudy Ho wrote:
>>>>> Change since v27:
>>>>> - Rebase on v6.0-rc2
>>>>> - Delete duplicate config in MDP3 Kconfig
>>>>> - Relist maintainers in newly added bindings
>>>>> - Minor changes in mtk-mdp3-comp.c and mtk-mdp3-reg.c to
>>>>>     avoid unnecessary long line warnings.
>>>>> - The v4l2-compliance test results are the same as v26.
>>>>>
>>>>> Change since v26:
>>>>> - Set MMSYS config from "depend on" to "select" in MDP3 Kconfig
>>>>>     to avoid compilation errors of various combinations.
>>>>> - Fix cast to smaller integer type 'enum mdp_comp_type' from
>>>>>     'const void *' in mtk_mdp3_comp.c.
>>>>> - Fix sparse warnings in mtk_mdp3_comp.c.
>>>>> - The v4l2-compliance test results are the same as v26.
>>>>>
>>>>> Change since v25:
>>>>> - Add more COMPILE_TEST config in MDP3 Kconfig
>>>>> - Adjust unnecessary log level in "mdp_m2m_s_selection" function
>>>>> to
>>>>>     avoid spamming the kernel log for userspace errors.
>>>>> - The v4l2-compliance test results list is as follows:
>>>>>
>>>>> 	v4l2-compliance 1.23.0-4942, 32 bits, 32-bit time_t
>>>>> 	v4l2-compliance SHA: 4cf258c24026 2022-07-28 15:43:45
>>>>> 	
>>>>> 	Compliance test for mtk-mdp3 device /dev/video0:
>>>>> 	
>>>>> 	Driver Info:
>>>>> 		Driver name      : mtk-mdp3
>>>>> 		Card type        : MediaTek MDP3
>>>>> 		Bus info         : platform:14001000.mdp3-rdma0
>>>>> 		Driver version   : 6.0.0
>>>>> 		Capabilities     : 0x84204000
>>>>> 			Video Memory-to-Memory Multiplanar
>>>>> 			Streaming
>>>>> 			Extended Pix Format
>>>>> 			Device Capabilities
>>>>> 		Device Caps      : 0x04204000
>>>>> 			Video Memory-to-Memory Multiplanar
>>>>> 			Streaming
>>>>> 			Extended Pix Format
>>>>> 	Required ioctls:
>>>>> 		test VIDIOC_QUERYCAP: OK
>>>>> 		test invalid ioctls: OK
>>>>> 	Allow for multiple opens:
>>>>> 		test second /dev/video0 open: OK
>>>>> 		test VIDIOC_QUERYCAP: OK
>>>>> 		test VIDIOC_G/S_PRIORITY: OK
>>>>> 		test for unlimited opens: OK
>>>>> 	Debug ioctls:
>>>>> 		test VIDIOC_DBG_G/S_REGISTER: OK (Not Supported)
>>>>> 		test VIDIOC_LOG_STATUS: OK (Not Supported)
>>>>> 	Input ioctls:
>>>>> 		test VIDIOC_G/S_TUNER/ENUM_FREQ_BANDS: OK (Not
>>>>> Supported)
>>>>> 		test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
>>>>> 		test VIDIOC_S_HW_FREQ_SEEK: OK (Not Supported)
>>>>> 		test VIDIOC_ENUMAUDIO: OK (Not Supported)
>>>>> 		test VIDIOC_G/S/ENUMINPUT: OK (Not Supported)
>>>>> 		test VIDIOC_G/S_AUDIO: OK (Not Supported)
>>>>> 		Inputs: 0 Audio Inputs: 0 Tuners: 0
>>>>> 	Output ioctls:
>>>>> 		test VIDIOC_G/S_MODULATOR: OK (Not Supported)
>>>>> 		test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
>>>>> 		test VIDIOC_ENUMAUDOUT: OK (Not Supported)
>>>>> 		test VIDIOC_G/S/ENUMOUTPUT: OK (Not Supported)
>>>>> 		test VIDIOC_G/S_AUDOUT: OK (Not Supported)
>>>>> 		Outputs: 0 Audio Outputs: 0 Modulators: 0
>>>>> 	Input/Output configuration ioctls:
>>>>> 		test VIDIOC_ENUM/G/S/QUERY_STD: OK (Not Supported)
>>>>> 		test VIDIOC_ENUM/G/S/QUERY_DV_TIMINGS: OK (Not
>>>>> Supported)
>>>>> 		test VIDIOC_DV_TIMINGS_CAP: OK (Not Supported)
>>>>> 		test VIDIOC_G/S_EDID: OK (Not Supported)
>>>>> 	Control ioctls:
>>>>> 		test VIDIOC_QUERY_EXT_CTRL/QUERYMENU: OK
>>>>> 		test VIDIOC_QUERYCTRL: OK
>>>>> 		test VIDIOC_G/S_CTRL: OK
>>>>> 		test VIDIOC_G/S/TRY_EXT_CTRLS: OK
>>>>> 		test VIDIOC_(UN)SUBSCRIBE_EVENT/DQEVENT: OK
>>>>> 		test VIDIOC_G/S_JPEGCOMP: OK (Not Supported)
>>>>> 		Standard Controls: 4 Private Controls: 0
>>>>> 	Format ioctls:
>>>>> 		test VIDIOC_ENUM_FMT/FRAMESIZES/FRAMEINTERVALS: OK
>>>>> 		test VIDIOC_G/S_PARM: OK (Not Supported)
>>>>> 		test VIDIOC_G_FBUF: OK (Not Supported)
>>>>> 		test VIDIOC_G_FMT: OK
>>>>> 		test VIDIOC_TRY_FMT: OK
>>>>> 		test VIDIOC_S_FMT: OK
>>>>> 		test VIDIOC_G_SLICED_VBI_CAP: OK (Not Supported)
>>>>> 		test Cropping: OK
>>>>> 		test Composing: OK
>>>>> 		test Scaling: OK
>>>>> 	Codec ioctls:
>>>>> 		test VIDIOC_(TRY_)ENCODER_CMD: OK (Not Supported)
>>>>> 		test VIDIOC_G_ENC_INDEX: OK (Not Supported)
>>>>> 		test VIDIOC_(TRY_)DECODER_CMD: OK (Not Supported)
>>>>> 	Buffer ioctls:
>>>>> 		test VIDIOC_REQBUFS/CREATE_BUFS/QUERYBUF: OK
>>>>> 		test VIDIOC_EXPBUF: OK
>>>>> 		test Requests: OK (Not Supported)
>>>>> 		test TIME32/64: OK
>>>>> 	Test input 0:
>>>>> 	Streaming ioctls:
>>>>> 		test read/write: OK (Not Supported)
>>>>> 		test blocking wait: OK
>>>>> 		<snip>
>>>>> 		test MMAP (no poll): OK
>>>>> 		<snip>
>>>>> 		test MMAP (select): OK
>>>>> 		<snip>
>>>>> 		test MMAP (epoll): OK
>>>>> 		test USERPTR (no poll): OK (Not Supported)
>>>>> 		test USERPTR (select): OK (Not Supported)
>>>>> 		test DMABUF: Cannot test, specify --expbuf-device
>>>>> 	Stream using all formats:
>>>>> 		<snip>
>>>>> 	Total for mtk-mdp3 device /dev/video0: 1592, Succeeded: 1592,
>>>>> Failed: 0, Warnings: 0
>>>>>
>>>>> Change since v24:
>>>>> - Rebase on v6.0-rc1.
>>>>>
>>>>> Change since v23:
>>>>> - Rebase on linux-next.
>>>>> - Fix compilation error.
>>>>>
>>>>> Change since v22:
>>>>> - Rebase on linux-next.
>>>>> - Fix typo about MDP3 in Kconfig.
>>>>> - Adjust some non-essential logs to lower levels.
>>>>>
>>>>> Change since v21:
>>>>> - Rebase on linux-next.
>>>>> - Following Hans suggestion, remove redundant kernel logs and
>>>>>     revise a few non-functional code to make it clearer.
>>>>> - Remove API abuse to set plane size.
>>>>> - Added VPU send message failure error code for previous
>>>>> shortages.
>>>>>
>>>>> Change since v20:
>>>>> - Rebase on linux-next.
>>>>> - Move the MDP3 GCE events to the corresponding node and adjust
>>>>> the
>>>>>     relevant driver settings.
>>>>>
>>>>> Change since v19:
>>>>> - Rebase on linux-next.
>>>>> - Export the function "mdp_cmdq_send" suggected by CK.
>>>>> - Fix "Macro argument reuse" reported by checkpatch.pl
>>>>>
>>>>> Change since v18:
>>>>> - Rebase on linux-next.
>>>>> - Adjust copyright date of MDP3 driver.
>>>>> - Functions renaming as follows:
>>>>>     [1] is_output_disable() => is_output_disabled()
>>>>>     [2] mdp_component_init() => mdp_comp_config()
>>>>>     [3] mdp_component_deinit() => mdp_comp_destroy()
>>>>>     [4] mdp_comp_ctx_init() => mdp_comp_ctx_config()
>>>>>     [5] mdp_sub_comps_create() => mdp_comp_sub_create()
>>>>> - Document MDP3 10-bit format descriptions in "mtk-mdp3-regs.c".
>>>>> - Add error control for functions mdp_comp_clocks_on and
>>>>> mdp_comp_clock_on.
>>>>> - Moved function "mtk_mutex_put" from function
>>>>>     "mdp_comp_destroy"(renamed from mdp_component_deinit) to avoid
>>>>> semantic ambiguity.
>>>>> - For some allocated parameters, assign a value of NULL after
>>>>> freeing
>>>>>     to avoid the possibility of repeated use.
>>>>> - Removed unnecessary timestamp pass flow.
>>>>> - About parameters passed by the user in function
>>>>> "mdp_try_fmt_mplane", add relevant checks to
>>>>>     clamp them in a reasonable range to avoid the possibility of
>>>>> overflow
>>>>>
>>>>> Change since v17:
>>>>> - Depend on:
>>>>>     [1]
>>>>>
>> https://urldefense.com/v3/__https://patchwork.kernel.org/project/linux-mediatek/list/?series=649104__;!!CTRNKA9wMg0ARbw!xBeR0XT4y6ExQRq_RVLLvqrEAiaNTJcM01gt8yzzXtwM3F5J-zx8-TF8imRuenzc$
>>>>>   
>>>>> - In response to future CMDQ api changes listed below:
>>>>>     
>>>>>
>> https://urldefense.com/v3/__https://patchwork.kernel.org/project/linux-mediatek/patch/20220608144055.27562-1-chunkuang.hu@kernel.org/__;!!CTRNKA9wMg0ARbw!xBeR0XT4y6ExQRq_RVLLvqrEAiaNTJcM01gt8yzzXtwM3F5J-zx8-TF8iul-Frc3$
>>>>>   
>>>>>     adjust CMDQ flush and callback flow in MDP3.
>>>>>
>>>>> Change since v16:
>>>>> - Rebased on v5.19-rc1
>>>>> - Depend on:
>>>>>     [1]
>>>>>
>> https://urldefense.com/v3/__https://patchwork.kernel.org/project/linux-mediatek/list/?series=646131__;!!CTRNKA9wMg0ARbw!xBeR0XT4y6ExQRq_RVLLvqrEAiaNTJcM01gt8yzzXtwM3F5J-zx8-TF8ivEMBOlg$
>>>>>   
>>>>> - In response to MUTEX changes, adjust API naming and parameters
>>>>> when
>>>>>     used in function "mdp_path_subfrm_require".
>>>>> - Remove unnecessary MDP3 phandle in 8183 dts.
>>>>>
>>>>> Change since v15:
>>>>> - Depend on:
>>>>>     [1]
>>>>>
>> https://urldefense.com/v3/__https://patchwork.kernel.org/project/linux-mediatek/list/?series=640926__;!!CTRNKA9wMg0ARbw!xBeR0XT4y6ExQRq_RVLLvqrEAiaNTJcM01gt8yzzXtwM3F5J-zx8-TF8ilOzZXlo$
>>>>>   
>>>>> - Split the bindings under ./soc/mediatek into a separate patch.
>>>>> - Fix data abort in "mdp_auto_release_work"
>>>>> - Adjust the steps in the function "mdp_cmdq_send" to make the
>>>>> error handling
>>>>>     more reasonable
>>>>>
>>>>> Change since v14:
>>>>> - Rebase on v5.18-rc6
>>>>> - Depend on:
>>>>>     [1]
>>>>>
>> https://urldefense.com/v3/__https://patchwork.kernel.org/project/linux-mediatek/list/?series=640926__;!!CTRNKA9wMg0ARbw!xBeR0XT4y6ExQRq_RVLLvqrEAiaNTJcM01gt8yzzXtwM3F5J-zx8-TF8ilOzZXlo$
>>>>>   
>>>>> - In response to CMDQ API change, replace the function
>>>>> "cmdq_pkt_flush_async"
>>>>>     with the standard APIs of mbox
>>>>> - Fix the description of "mediatek,gce-client-reg" property in
>>>>> MDP3-related
>>>>>     bindings
>>>>>
>>>>> Change since v13:
>>>>> - Rebase on v5.18-rc4
>>>>> - Depend on:
>>>>>     [1]
>>>>>
>> https://urldefense.com/v3/__https://patchwork.kernel.org/project/linux-mediatek/list/?series=636041__;!!CTRNKA9wMg0ARbw!xBeR0XT4y6ExQRq_RVLLvqrEAiaNTJcM01gt8yzzXtwM3F5J-zx8-TF8itpp6cBE$
>>>>>   
>>>>> - Remove advanced functionality about ISP settings for direct
>>>>> link
>>>>> cases.
>>>>> - Remove the software designation in the mt8183 dts and
>>>>>     revise corresponding bindings.
>>>>>
>>>>> Change since v12:
>>>>> - Rebase on linux-next
>>>>> - Depend on:
>>>>>     [1]
>>>>>
>> https://urldefense.com/v3/__https://patchwork.kernel.org/project/linux-mediatek/list/?series=630948__;!!CTRNKA9wMg0ARbw!xBeR0XT4y6ExQRq_RVLLvqrEAiaNTJcM01gt8yzzXtwM3F5J-zx8-TF8immtSFit$
>>>>>   
>>>>> - Remove messages related to routing information in MDP3, and
>>>>> leave
>>>>> the related
>>>>>     settings in MMSYS.
>>>>> - Remove unnecessary phandle and redundant property in RDMA dt-
>>>>> binding and
>>>>>     adjust the corresponding driver.
>>>>> - Revise MDP3 node name in dts.
>>>>> - Removed unnecessary functions, mutex and work queue in MDP3
>>>>> driver
>>>>> - Fixed format mapping error for V4L2_PIX_FMT_RGB565X
>>>>>
>>>>> Change since v11:
>>>>> - Rebase on linux-next tag:next-20220316
>>>>> - Depend on:
>>>>>     [1]
>>>>>
>> https://urldefense.com/v3/__https://patchwork.kernel.org/project/linux-mediatek/list/?series=624281__;!!CTRNKA9wMg0ARbw!xBeR0XT4y6ExQRq_RVLLvqrEAiaNTJcM01gt8yzzXtwM3F5J-zx8-TF8iu7IwX8m$
>>>>>   
>>>>> - Remove redundant hardware index in data-binding suggested by
>>>>> Rob
>>>>> Herring.
>>>>> - Referring to Rob Herring's suggestion to improve some
>>>>> descriptions in the
>>>>>     RDMA dt-binding
>>>>> - Move MDP3 file folder from "./drive/media/platform/mtk-mdp3" to
>>>>>     "./driver/media/platform/mediatek/mdp3"
>>>>> - Fixed the V4L2 and MDP color format mapping error in RGB565
>>>>> which
>>>>>     checked by Benjamin Gaignard
>>>>>
>>>>> Change since v10:
>>>>> - The routing table needs to be discarded, and the calculation
>>>>> result
>>>>>     on the SCP side is used to write a suitable mux setting for
>>>>>     1 input port and 2 output ports.
>>>>> - Adjust dts parsing flow to remove redundant HW IDs.
>>>>> - Fix memory leak caused by no free path information in function
>>>>> "mdp_cmdq_send".
>>>>>
>>>>> Change since v9:
>>>>> - Keep only the MDP3 driver patches and split the remaining mmsys
>>>>> and
>>>>>     mutex patches into another mail.
>>>>> - Move mutex mod settings to corresponding driver and make
>>>>> relevant
>>>>> adjustments
>>>>>     for this in MDP3 driver.
>>>>> - Fix compile warning reported by kernel test robot.
>>>>>
>>>>> Change since v8:
>>>>> - Rebase on v5.16-rc2.
>>>>> - Refer to Angelo's suggestion, adjust the register writing
>>>>> format
>>>>> to increase
>>>>>     readability and significance.
>>>>> - Refer to Angelo's suggestion, adjust or reduce inappropriate
>>>>> debugging
>>>>>     messages.
>>>>> - Refer to Rob Herring's suggestion to correct the the binding
>>>>> file
>>>>>     to make it with the specification.
>>>>> - Fix compile warning reported by kernel test robot.
>>>>>
>>>>> Change since v7:
>>>>> - Rebase on v5.15-rc6.
>>>>> - Revise several V4L2 M2M settings to pass v4l2-compliance test.
>>>>> - Integrate those same component dt-binding documents of DRM and
>>>>> MDP, and
>>>>>     move them under the MMSYS domain.
>>>>> - Split MMSYS and MUTEX into two different files according to
>>>>>     their functional properties.
>>>>>
>>>>> Changes since v6:
>>>>> - Refactor GCE event to corresponding node.
>>>>> - Fix dt_binding_check fail.
>>>>> - Fix compilation errors.
>>>>>
>>>>> Changes since v5:
>>>>> - Rebase on v5.14-rc6.
>>>>> - Move MMSYS/Mutex settings to corresponding driver.
>>>>> - Revise the software license description and copyright.
>>>>> - Remove unnecessary enum. or definitions.
>>>>> - Optimize platform/chip definition conditions.
>>>>> - Use general printing functions instead of MDP3 private ones.
>>>>> - Fix compile warning.
>>>>>
>>>>> Changes since v4:
>>>>> - Rebase on v5.13-rc1.
>>>>> - Remove the CMDQ flush flow to match the CMDQ API change.
>>>>> - Integrate four of MDP's direct-link subcomponents into MDP
>>>>> controller node
>>>>>     from syscon node to avoid illegal clock usage.
>>>>> - Rewrite dt-binding in a JSON compatible subset of YAML
>>>>> - Fix a bit of macro argument precedence.
>>>>>
>>>>> Changes since v3:
>>>>> - Rebase on v5.9-rc1.
>>>>> - modify code for review comment from Rob Herring, cancel
>>>>> multiple
>>>>> nodes using
>>>>>     same register base situation.
>>>>> - control IOMMU port through pm runtime get/put to DMA
>>>>> components'
>>>>> device.
>>>>> - SCP(VPU) driver revision.
>>>>> - stop queuing jobs(remove flush_workqueue()) after
>>>>> mdp_m2m_release().
>>>>> - add computation of plane address with data_offset.
>>>>> - fix scale ratio check issue.
>>>>> - add default v4l2_format setting.
>>>>>
>>>>> Changes since v2:
>>>>> - modify code for review comment from Tomasz Figa & Alexandre
>>>>> Courbot
>>>>> - review comment from Rob Herring will offer code revision in v4,
>>>>> due to
>>>>>     it's related to device node modification, will need to modify
>>>>> code
>>>>>     architecture
>>>>>
>>>>> Changes since v1:
>>>>> - modify code for CMDQ v3 API support
>>>>> - EC ipi cmd migration
>>>>> - fix compliance test fail item (m2m cmd with -f) due to there is
>>>>> two problem in
>>>>>     runing all format(-f) cmd:
>>>>> 1. out of memory before test complete
>>>>>           Due to capture buffer mmap (refcount + 1) after reqbuf
>>>>> but
>>>>> seems
>>>>>           no corresponding munmap called before device close.
>>>>>           There are total 12XX items(formats) in format test and
>>>>> each format
>>>>>           alloc 8 capture/output buffers.
>>>>> 2. unceasingly captureBufs() (randomly)
>>>>>           Seems the break statement didn't catch the count == 0
>>>>> situation:
>>>>>           In v4l2-test-buffers.cpp, function: captureBufs()
>>>>>                           ...
>>>>>                           count--;
>>>>>                           if (!node->is_m2m && !count)
>>>>>                                   break;
>>>>>           Log is as attachment
>>>>>
>>>>> Hi,
>>>>>
>>>>> This patch is used to present Media Data Path 3 (MDP3)
>>>>> which provided scaling and color format conversion.
>>>>> support using GCE to write register in critical time limitation.
>>>>> support V4L2 m2m device control.
>>>>>
>>>>>
>>>>> Moudy Ho (4):
>>>>>     dt-binding: mediatek: add bindings for MediaTek MDP3
>>>>> components
>>>>>     dt-binding: mediatek: add bindings for MediaTek CCORR and WDMA
>>>>>     arm64: dts: mt8183: add MediaTek MDP3 nodes
>>>>>     media: platform: mtk-mdp3: add MediaTek MDP3 driver
>>>>>
>>>>>    .../bindings/media/mediatek,mdp3-rdma.yaml    |   95 ++
>>>>>    .../bindings/media/mediatek,mdp3-rsz.yaml     |   77 ++
>>>>>    .../bindings/media/mediatek,mdp3-wrot.yaml    |   80 ++
>>>>>    .../bindings/soc/mediatek/mediatek,ccorr.yaml |   68 ++
>>>>>    .../bindings/soc/mediatek/mediatek,wdma.yaml  |   81 ++
>>>>>    arch/arm64/boot/dts/mediatek/mt8183.dtsi      |   63 +
>>>>>    drivers/media/platform/mediatek/Kconfig       |    1 +
>>>>>    drivers/media/platform/mediatek/Makefile      |    1 +
>>>>>    drivers/media/platform/mediatek/mdp3/Kconfig  |   20 +
>>>>>    drivers/media/platform/mediatek/mdp3/Makefile |    6 +
>>>>>    .../platform/mediatek/mdp3/mdp_reg_ccorr.h    |   19 +
>>>>>    .../platform/mediatek/mdp3/mdp_reg_rdma.h     |   65 ++
>>>>>    .../platform/mediatek/mdp3/mdp_reg_rsz.h      |   39 +
>>>>>    .../platform/mediatek/mdp3/mdp_reg_wdma.h     |   47 +
>>>>>    .../platform/mediatek/mdp3/mdp_reg_wrot.h     |   55 +
>>>>>    .../platform/mediatek/mdp3/mtk-img-ipi.h      |  290 +++++
>>>>>    .../platform/mediatek/mdp3/mtk-mdp3-cmdq.c    |  466 ++++++++
>>>>>    .../platform/mediatek/mdp3/mtk-mdp3-cmdq.h    |   43 +
>>>>>    .../platform/mediatek/mdp3/mtk-mdp3-comp.c    | 1033
>>>>> +++++++++++++++++
>>>>>    .../platform/mediatek/mdp3/mtk-mdp3-comp.h    |  186 +++
>>>>>    .../platform/mediatek/mdp3/mtk-mdp3-core.c    |  357 ++++++
>>>>>    .../platform/mediatek/mdp3/mtk-mdp3-core.h    |   94 ++
>>>>>    .../platform/mediatek/mdp3/mtk-mdp3-m2m.c     |  724
>>>>> ++++++++++++
>>>>>    .../platform/mediatek/mdp3/mtk-mdp3-m2m.h     |   48 +
>>>>>    .../platform/mediatek/mdp3/mtk-mdp3-regs.c    |  735
>>>>> ++++++++++++
>>>>>    .../platform/mediatek/mdp3/mtk-mdp3-regs.h    |  373 ++++++
>>>>>    .../platform/mediatek/mdp3/mtk-mdp3-vpu.c     |  313 +++++
>>>>>    .../platform/mediatek/mdp3/mtk-mdp3-vpu.h     |   78 ++
>>>>>    28 files changed, 5457 insertions(+)
>>>>>    create mode 100644
>>>>> Documentation/devicetree/bindings/media/mediatek,mdp3-rdma.yaml
>>>>>    create mode 100644
>>>>> Documentation/devicetree/bindings/media/mediatek,mdp3-rsz.yaml
>>>>>    create mode 100644
>>>>> Documentation/devicetree/bindings/media/mediatek,mdp3-wrot.yaml
>>>>>    create mode 100644
>>>>> Documentation/devicetree/bindings/soc/mediatek/mediatek,ccorr.yam
>>>>> l
>>>>>    create mode 100644
>>>>> Documentation/devicetree/bindings/soc/mediatek/mediatek,wdma.yaml
>>>>>    create mode 100644 drivers/media/platform/mediatek/mdp3/Kconfig
>>>>>    create mode 100644
>>>>> drivers/media/platform/mediatek/mdp3/Makefile
>>>>>    create mode 100644
>>>>> drivers/media/platform/mediatek/mdp3/mdp_reg_ccorr.h
>>>>>    create mode 100644
>>>>> drivers/media/platform/mediatek/mdp3/mdp_reg_rdma.h
>>>>>    create mode 100644
>>>>> drivers/media/platform/mediatek/mdp3/mdp_reg_rsz.h
>>>>>    create mode 100644
>>>>> drivers/media/platform/mediatek/mdp3/mdp_reg_wdma.h
>>>>>    create mode 100644
>>>>> drivers/media/platform/mediatek/mdp3/mdp_reg_wrot.h
>>>>>    create mode 100644 drivers/media/platform/mediatek/mdp3/mtk-
>>>>> img-
>>>>> ipi.h
>>>>>    create mode 100644 drivers/media/platform/mediatek/mdp3/mtk-
>>>>> mdp3-
>>>>> cmdq.c
>>>>>    create mode 100644 drivers/media/platform/mediatek/mdp3/mtk-
>>>>> mdp3-
>>>>> cmdq.h
>>>>>    create mode 100644 drivers/media/platform/mediatek/mdp3/mtk-
>>>>> mdp3-
>>>>> comp.c
>>>>>    create mode 100644 drivers/media/platform/mediatek/mdp3/mtk-
>>>>> mdp3-
>>>>> comp.h
>>>>>    create mode 100644 drivers/media/platform/mediatek/mdp3/mtk-
>>>>> mdp3-
>>>>> core.c
>>>>>    create mode 100644 drivers/media/platform/mediatek/mdp3/mtk-
>>>>> mdp3-
>>>>> core.h
>>>>>    create mode 100644 drivers/media/platform/mediatek/mdp3/mtk-
>>>>> mdp3-
>>>>> m2m.c
>>>>>    create mode 100644 drivers/media/platform/mediatek/mdp3/mtk-
>>>>> mdp3-
>>>>> m2m.h
>>>>>    create mode 100644 drivers/media/platform/mediatek/mdp3/mtk-
>>>>> mdp3-
>>>>> regs.c
>>>>>    create mode 100644 drivers/media/platform/mediatek/mdp3/mtk-
>>>>> mdp3-
>>>>> regs.h
>>>>>    create mode 100644 drivers/media/platform/mediatek/mdp3/mtk-
>>>>> mdp3-
>>>>> vpu.c
>>>>>    create mode 100644 drivers/media/platform/mediatek/mdp3/mtk-
>>>>> mdp3-
>>>>> vpu.h
>>>>>
>>

