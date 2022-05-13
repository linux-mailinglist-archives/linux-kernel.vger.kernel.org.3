Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 089A5526504
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 16:44:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237552AbiEMOo3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 10:44:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382844AbiEMOnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 10:43:18 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9470E1FA42;
        Fri, 13 May 2022 07:41:49 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 17DB41F461AE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652452908;
        bh=6Dco2Ss56mOS9SRrFtH4AnkhAjVH1fenM6f9Oc0sjC4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=PHwvr64OiJ3wiXjognKoyniZXsfJS2BHOEgLZL81mpS7mTGLmwGwDDrcKBgg8GbG/
         4qJ+ORQM1R9yn8rG+1Yiubm8Hks8W4EMZcg5PZpL+Us36bUd34Z5cVIfo+f25kLiht
         7x08AlU5aT2SaTQwfUw4YtKN3TJJ3+eo7JX305Qf2Tu43TN2mkkQ4X4rRAhvcvdgQq
         Pk7LKnf4O1OEa5wXnnY2zULxJlj21g5J6NJI9fl5oOcM1W14GdtTh8jnlSX0EK27b1
         QMDw9uNxEV410GPnN0/JRFK0wx0JvD5rM4kg8izQ++IMGCgzIMwxnPSP3JhxYVSUgN
         Ec2ir55GmrrcQ==
Message-ID: <41cbfd34-e3e6-e041-2cb6-bbf28782a299@collabora.com>
Date:   Fri, 13 May 2022 16:41:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 1/2] Bluetooth: btmtksdio: fix the reset takes too long
Content-Language: en-US
To:     sean.wang@mediatek.com, marcel@holtmann.org,
        johan.hedberg@gmail.com
Cc:     Soul.Huang@mediatek.com, YN.Chen@mediatek.com,
        Leon.Yen@mediatek.com, Eric-SY.Chang@mediatek.com,
        Deren.Wu@mediatek.com, km.lin@mediatek.com,
        robin.chiu@mediatek.com, Eddie.Chen@mediatek.com,
        ch.yeh@mediatek.com, posh.sun@mediatek.com, ted.huang@mediatek.com,
        Eric.Liang@mediatek.com, Stella.Chang@mediatek.com,
        Tom.Chou@mediatek.com, steve.lee@mediatek.com, jsiuda@google.com,
        frankgor@google.com, abhishekpandit@google.com,
        michaelfsun@google.com, mcchou@chromium.org, shawnku@google.com,
        linux-bluetooth@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yake Yang <yake.yang@mediatek.com>
References: <e26167a3fcefdeae1151162e8676c9a467a8100d.1652390894.git.objelf@gmail.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <e26167a3fcefdeae1151162e8676c9a467a8100d.1652390894.git.objelf@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 12/05/22 23:38, sean.wang@mediatek.com ha scritto:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> Sending WMT command during the reset in progress is invalid and would get
> no response from firmware until the reset is complete, so we ignore the WMT
> command here to resolve the issue which causes the whole reset process
> taking too long.
> 
> Fixes: 8fafe702253d ("Bluetooth: mt7921s: support bluetooth reset mechanism")
> Co-developed-by: Yake Yang <yake.yang@mediatek.com>
> Signed-off-by: Yake Yang <yake.yang@mediatek.com>
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>

It may be too late but, in any case, for the entire series:

Tested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

