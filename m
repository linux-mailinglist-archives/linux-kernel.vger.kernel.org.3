Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C0F7514FC5
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 17:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378603AbiD2PnR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 11:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231540AbiD2PnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 11:43:15 -0400
Received: from mail-m121145.qiye.163.com (mail-m121145.qiye.163.com [115.236.121.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13E2AD76C6
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 08:39:54 -0700 (PDT)
Received: from [192.168.3.48] (unknown [58.22.1.245])
        by mail-m121145.qiye.163.com (Hmail) with ESMTPA id 02F4C800387;
        Fri, 29 Apr 2022 23:39:52 +0800 (CST)
Message-ID: <24c08c1e-e4b5-3731-de33-e75a9b4bdf1f@rock-chips.com>
Date:   Fri, 29 Apr 2022 23:39:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] ASoC: hdmi-codec: Add option for ELD bypass
To:     Mark Brown <broonie@kernel.org>
Cc:     Dmitry Osipenko <digetx@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
References: <1651245218-47201-1-git-send-email-sugar.zhang@rock-chips.com>
 <YmwDv7poot/5pcgb@sirena.org.uk>
From:   sugar zhang <sugar.zhang@rock-chips.com>
In-Reply-To: <YmwDv7poot/5pcgb@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZCBgUCR5ZQVlLVUtZV1
        kWDxoPAgseWUFZKDYvK1lXWShZQUhPN1dZLVlBSVdZDwkaFQgSH1lBWUJJSE1WSUJITkkeGBlJSU
        NOVRMBExYaEhckFA4PWVdZFhoPEhUdFFlBWU9LSFVKSktITk9VS1kG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6M006ISo4ED0xIhcLMhkYIh4y
        Mk1PCy1VSlVKTU5KSU9NTEJITUlIVTMWGhIXVQgOHBoJVQETGhUcOwkUGBBWGBMSCwhVGBQWRVlX
        WRILWUFZTkNVSUlVSlVJT05ZV1kIAVlBSU5NQjcG
X-HM-Tid: 0a8075fa8274b03akuuu02f4c800387
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

在 2022/4/29 23:26, Mark Brown 写道:
> On Fri, Apr 29, 2022 at 11:13:38PM +0800, Sugar Zhang wrote:
>
>> So, add this option to allow user to select the manual way
>> to output audio as expected. such as multi-channels LPCM(7.1),
>> or HBR bitstream for these sink devices.
> Please check this with mixer-test, it'll help validate that you've got
> the control interface correct.
Okay, I have found it in the tools/testing/selftests/alsa/mixer-test.c
>
>>   		.info	= hdmi_eld_ctl_info,
>>   		.get	= hdmi_eld_ctl_get,
>>   	},
>> +	HDMI_CODEC_ELD_BYPASS_DECL("ELD Bypass"),
> This is a true/false value so the name should end with Switch.
will do in v2.

-- 
Best Regards!
张学广/Sugar
瑞芯微电子股份有限公司
Rockchip Electronics Co., Ltd.

