Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9515950285C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 12:33:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352334AbiDOKfT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 06:35:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240535AbiDOKfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 06:35:16 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B428BBB937;
        Fri, 15 Apr 2022 03:32:48 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id C85F21F47E6B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1650018767;
        bh=nlyT9uQbkjzioWEO7W6j0Auq0HCeIzNo2fkjz3Pa5Bo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=PhpUX9sJw3idQnExRhUN2jNHlw5zgo9InQmuXeIt/zr3f9kXox4eLopzl46snvjoK
         PW44SeAuzTuIPuiCHcpCu9Wf0/7GrabvSMNLTqZs+oFp9f5P7qC5UcNb7i0UTn0U6r
         G1c9zNMf1Bvjk79ml8RoYpQ3t8PmyU6ViAo0taWQCD92hkFrPAbj+5HZDvAcDmrPB4
         cDDnyOpmn08p0cbZO06axCyBwNBbarJVSu5PP+ulbn5o1EKYBCdDIjOB5TPHf/mvwj
         SvOnSkoXSgJhn24uopJkFOU6dDwq0lQm/eWYXmk1xYKTIqnBGCMTQDEoUpuj0wsR03
         8NoqlVfBgFyYQ==
Message-ID: <7f5a4307-b28d-1072-ee1d-752b3761bc30@collabora.com>
Date:   Fri, 15 Apr 2022 12:32:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v19 09/10] drm/mediatek: add postfix 0 to
 DDP_COMPONENT_DITHER for mt8195 vdosys0
Content-Language: en-US
To:     "jason-jh.lin" <jason-jh.lin@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc:     CK Hu <ck.hu@mediatek.com>, Nancy Lin <nancy.lin@mediatek.com>,
        Singo Chang <singo.chang@mediatek.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220415083911.5186-1-jason-jh.lin@mediatek.com>
 <20220415083911.5186-10-jason-jh.lin@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220415083911.5186-10-jason-jh.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 15/04/22 10:39, jason-jh.lin ha scritto:
> Because mt8195 vdosys0 has 2 DITHER components,
> so the postfix 0 need to be added to DDP_COMPONENT_DITHER.
> 
> Then DITHER enum will become:
> DDP_COMPONENT_DITHER0 and DDP_COMPONENT_DITHER1.
> 
> Signed-off-by: jason-jh.lin <jason-jh.lin@mediatek.com>

I think that "postfix" should be "suffix" instead :)))

In any case:

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

