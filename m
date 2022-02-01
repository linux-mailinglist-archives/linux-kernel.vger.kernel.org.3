Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 120464A58D1
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 09:54:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235443AbiBAIyz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 03:54:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231912AbiBAIyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 03:54:53 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB35BC061714
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 00:54:52 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id E38851F438FB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1643705690;
        bh=cX6n8y9xqw3fyjvPkbflYeNt2MpCla3htWHQ0GpzOts=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=GJGaCITCXqQz2ChA2swrnHl7qatLEV8wEXtJMTwWsdv+EbNZdVsXrQaOBpKyzB/gG
         XFGiuUG15jZovcZOSwY+YpHwTzCfGZEqqii2d/XJ+mVOwXqhdpYQv5MKYL2VBcGZjt
         xWEUJXgYXAvHdUaRo0FzkyREoCsgX6ylFDKkTqOFN0Phw3Y5LFbxVXZJcZb6RRNhNP
         EuQD844FmkVOzuMuVbMNeZdKfhaEY+1mFpi1cx5jbZT+Ni+8xiuzFB+U9Y6J1EbwJL
         /mbkmWn7Ymg2Avlze52JoA1NcGLX04LY1pV3LQGSrCTWCghynYBVvCjlTnf1dU/dJF
         HSqOCN2bhAeVw==
Message-ID: <90ec652d-6df7-3e7b-dd81-7ced053e1dcf@collabora.com>
Date:   Tue, 1 Feb 2022 09:54:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v11] drm/bridge: add it6505 driver
Content-Language: en-US
To:     Robert Foss <robert.foss@linaro.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     allen <allen.chen@ite.com.tw>,
        Kenneth Hung <Kenneth.Hung@ite.com.tw>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jau-Chih Tseng <Jau-Chih.Tseng@ite.com.tw>,
        David Airlie <airlied@linux.ie>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        open list <linux-kernel@vger.kernel.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        Hermes Wu <Hermes.Wu@ite.com.tw>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Hsin-Yi Wang <hsinyi@google.com>
References: <20220114091502.333083-1-allen.chen@ite.com.tw>
 <f4696a8d-5c1d-1007-7814-b2e6cbe334ae@collabora.com>
 <CAG3jFytN9iu0BteAxFCLVRorxM20Q3Zrfn1T4k8bnDYy5oL7bg@mail.gmail.com>
 <CAJMQK-i6M1hwESSA5OJ6TpdBBBEG8K9esSbLv-Xjb_zqCoB5ug@mail.gmail.com>
 <CAG3jFyvgvfjo-HgL8wWWXtaoJvUupd2zJt=neVJZn5uVESyZFA@mail.gmail.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <CAG3jFyvgvfjo-HgL8wWWXtaoJvUupd2zJt=neVJZn5uVESyZFA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 31/01/22 19:36, Robert Foss ha scritto:
> On Mon, 31 Jan 2022 at 17:55, Hsin-Yi Wang <hsinyi@chromium.org> wrote:
>>
>> On Tue, Feb 1, 2022 at 12:37 AM Robert Foss <robert.foss@linaro.org> wrote:
>>>
>>> On Thu, 20 Jan 2022 at 16:25, AngeloGioacchino Del Regno
>>> <angelogioacchino.delregno@collabora.com> wrote:
>>>>
>>>> Il 14/01/22 10:14, allen ha scritto:
>>>>> This adds support for the iTE IT6505.
>>>>> This device can convert DPI signal to DP output.
>>>>>
>>>>> From: Allen Chen <allen.chen@ite.com.tw>
>>>>> Tested-by: Hsin-yi Wang <hsinyi@chromium.org>
>>>>> Signed-off-by: Hermes Wu <hermes.wu@ite.com.tw>
>>>>> Signed-off-by: Allen Chen <allen.chen@ite.com.tw>
>>>>> ---
>>>>> v10 -> v11 : remove drm_bridge_new_crtc_state
>>>>> ---
>>>>>    drivers/gpu/drm/bridge/Kconfig      |    8 +
>>>>>    drivers/gpu/drm/bridge/Makefile     |    1 +
>>>>>    drivers/gpu/drm/bridge/ite-it6505.c | 3352 +++++++++++++++++++++++++++
>>>>>    3 files changed, 3361 insertions(+)
>>>>>    create mode 100644 drivers/gpu/drm/bridge/ite-it6505.c
>>>>>
>>>>
>>>> ...snip...
>>>>
>>>>> +static const struct of_device_id it6505_of_match[] = {
>>>>> +     { .compatible = "ite,it6505" },
>>>>> +     { }
>>>>> +};
>>>>
>>>> If you want to have a DT compatible and DT properties, you have to also add
>>>> dt-bindings (yaml) for this driver, otherwise, any SoC/device DT will fail
>>>> the dt binding check.... So, please, add that.
>>>
>>> Let me second this. A dt-binding is needed for this driver to be
>>> complete, it functions as both documentation and a way to test the DTS
>>> that use this device, so it is really important.
>>>
>> The binding seems to be accepted before the driver:
>> https://elixir.bootlin.com/linux/v5.16.4/source/Documentation/devicetree/bindings/display/bridge/ite,it6505.yaml
> 
> I completely missed that. In that case we're only missing the
> reviewed-by tag from someone.
> 

You have mine... the intention was to give a Reviewed-by, not a Acked-by - I'm
sorry for that, I was sending more than one email and the wrong tag slipped
through.

So, please change my Acked-by tag to

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

>>
>>>>
>>>> For the driver by itself, though:
>>>>
>>>> Acked-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>>>>
>>>>> +
>>>>> +static struct i2c_driver it6505_i2c_driver = {
>>>>> +     .driver = {
>>>>> +             .name = "it6505",
>>>>> +             .of_match_table = it6505_of_match,
>>>>> +             .pm = &it6505_bridge_pm_ops,
>>>>> +     },
>>>>> +     .probe = it6505_i2c_probe,
>>>>> +     .remove = it6505_i2c_remove,
>>>>> +     .shutdown = it6505_shutdown,
>>>>> +     .id_table = it6505_id,
>>>>> +};
>>>>> +
>>>>> +module_i2c_driver(it6505_i2c_driver);
>>>>> +
>>>>> +MODULE_AUTHOR("Allen Chen <allen.chen@ite.com.tw>");
>>>>> +MODULE_DESCRIPTION("IT6505 DisplayPort Transmitter driver");
>>>>> +MODULE_LICENSE("GPL v2");
>>>>>
>>>>


