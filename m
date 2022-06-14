Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D644D54A99A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 08:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239790AbiFNGj2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 02:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231724AbiFNGj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 02:39:26 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E9DB37BCF
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 23:39:25 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id AF7045C006E;
        Tue, 14 Jun 2022 02:39:22 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 14 Jun 2022 02:39:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1655188762; x=
        1655275162; bh=YLErNvqZx1IawB0vUHwDOxvcYy8H5o0KiKQdt10QrzY=; b=U
        +UE/qlH2+74a1pdC++OqXtWIXXd/Vn6hgnkHOon4r+GApTLm1chn1Eni8QBPivqK
        1DmND3dY5Lf5l0GtWXgt7QPm0AjuZhExJ0tyQKw6z8CMimhdS0+wNoYmgHvQTQdK
        6BPZqxIr6RPnP/k6ILVSmKysxP9HS+LmzJiev4FiOjlzuKXI4lHk0X+5AY4Kc/ek
        j04+YuxYNLOr/nbKaAhNS2J4AP2gM+iBn9DZLrnO/OsbkpiFu9ll11FUiYaKBtWb
        HivOcOKV/KMN48CZcaWT1iu9FxgbHPBE42z7s/0JR1XrGveuacyt7Vr8ubL/7DUu
        cgIttNkhTCs0Kk0zW1TVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1655188762; x=
        1655275162; bh=YLErNvqZx1IawB0vUHwDOxvcYy8H5o0KiKQdt10QrzY=; b=T
        F8hdFjasH8OZY7roQVqWv0Qu+ZYPa18MW26BlKNU9wKY5xC5zqLPIFKkzVO/ar8m
        dYHKe1jQY8qemfN7llew7vSEclxPNrk+rofePAwvISrHImsYBukiOzcxZV78H95Q
        78GK5cMHid6DhEdQ1xIwewusmUU04cZCaNEOoln1OA/8Ql5/yVKm8r2ribVYxfyN
        cS3FEH/4+MyDQsrq9hNfbW86pJg1ZlHa1bvrYkjvAL68tcaXqV32DrxGnm0c0K5t
        WEhthjanMBkjvE7IqTS1W5VezJ/o6VB0pcJdrE3r/8+w1s3qags4uZdJfgy1XB0b
        xyrJBkfVXl5/d0IpAi7ZA==
X-ME-Sender: <xms:Gi2oYnHgdP4g0INELdKQolrmQ7gncQUll3xIh5DO1oB1NVD7CPKCTQ>
    <xme:Gi2oYkUyi4d8wQArFGKLBpWpTW6DO6KfJegGUOLHQ-g2II_AwJlTbZG46fKCQ5S4X
    Ib0Yz8GiCAuYN10pw>
X-ME-Received: <xmr:Gi2oYpK9auqTk03rBrrS6TiPEsI7xv4_NogLK9VN90yHk_nevMwj9zaotIEuqN418N3IyoQqZIWLfq-muciFKWKEgtqBAukgqe7ojW0seZUGF8hMyashPMTyRA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedruddukedguddtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefuvfevfhfhkffffgggjggtgfesthejredttdefjeenucfhrhhomhepufgr
    mhhuvghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqne
    cuggftrfgrthhtvghrnhepffdtveekvdegkeeuueetgfetffeileevudekuefhheelvdfh
    iedtheduhfduhefhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:Gi2oYlFPP1lcV22QarSqf1uxSt0P4_OvAWNOBD4Y6BXqxT-9OAONlg>
    <xmx:Gi2oYtVPJ3pzCjVz7dUV-rNHoTbDRRgUCFdiTWXsLHroVPDi8BCpWA>
    <xmx:Gi2oYgP4uCMNpZO6zr3l9N94LkmiSqhnDmEmEoNTHJ8E3xhbOFRrpw>
    <xmx:Gi2oYlTmepW70fHSh9e8Uub9_Ckgpu5sZHiq_24x5-SXojU1XJuFFw>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Jun 2022 02:39:21 -0400 (EDT)
Subject: Re: [PATCH 1/2] ASoC: sun8i-codec: Partial revert to fix clock
 specifiers
To:     Charles Keepax <ckeepax@opensource.cirrus.com>, broonie@kernel.org
Cc:     matthias.bgg@gmail.com, wens@csie.org, jernej.skrabec@gmail.com,
        linux-mediatek@lists.infradead.org, linux-sunxi@lists.linux.dev,
        lgirdwood@gmail.com, alsa-devel@alsa-project.org,
        patches@opensource.cirrus.com, linux-kernel@vger.kernel.org
References: <20220613161552.481337-1-ckeepax@opensource.cirrus.com>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <9e105410-94d5-1801-8919-af8c0cef4de1@sholland.org>
Date:   Tue, 14 Jun 2022 01:39:20 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20220613161552.481337-1-ckeepax@opensource.cirrus.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Charles,

On 6/13/22 11:15 AM, Charles Keepax wrote:
> Recent updates accidentally updated the clock producer/consumer
> specifiers on this device as part of refactoring the CPU side of the DAI
> links. However, this device sits on the CODEC side and shouldn't have
> been updated. Partially revert the changes keeping the switch to the new
> clock terminology but going back to the CODEC defines.
> 
> Fixes: 7cc3965fde74 ("ASoC: sunxi: Update to use set_fmt_new callback")
> Reported-by: Samuel Holland <samuel@sholland.org>
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Reviewed-by: Samuel Holland <samuel@sholland.org>
Tested-by: Samuel Holland <samuel@sholland.org>

Thanks for the quick follow-up, and sorry for the confusion my earlier comment
caused. I verified that sound is broken (loud static) on a Pine A64-LTS board
with for-next, and is fixed by this patch.

Regards,
Samuel
