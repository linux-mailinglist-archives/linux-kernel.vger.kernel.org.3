Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16348509D56
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 12:16:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350974AbiDUKPm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 06:15:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388272AbiDUKPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 06:15:24 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7F4D2FE4A;
        Thu, 21 Apr 2022 03:12:08 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 8AA9D1F45483
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1650535927;
        bh=HPOrpLDJ/NYqVSsQ+sZ4XQLCeAYBNHE6ulTq2mIsJDc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=W98B6+rtp16cuw3lgkpd6JA8YrUWyrDUDS+Mj/UxJ4GP+7oFd1sUbklJ1QDBiTAzm
         m2ci2dmyJYPHDvtIi6kMUq1Yy/BbCjMFaw65IRUHQftiQg/CRO1TOmFumOWsSScKbc
         fRJ9MfHo8bUZVC6NYFcWTgJbL+1frzxj/7wSgPSwob60ulGk1S1a8gzf2lzuh0jbzm
         ve+52G2dyd8CeD0qfv2zlWcbbhoZimNrS9C3a7In65nuGZetHNhf/oOBSl2dzw3Ji/
         5/omW4tgdBxeR/U6ccdShnlc8/RaYJpJ9WgKpkfYgEac1zD7PAKEB5ANIEKhfYBKSB
         Dwj2BuYcCicqg==
Message-ID: <2703f3de-1ee9-36ca-4866-89398c501244@collabora.com>
Date:   Thu, 21 Apr 2022 12:12:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3 2/2] remoteproc: mediatek: allow reading firmware-name
 from DT
Content-Language: en-US
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Hsin-Yi Wang <hsinyi@chromium.org>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-remoteproc@vger.kernel.org
References: <20220419123331.14377-1-allen-kh.cheng@mediatek.com>
 <20220419123331.14377-3-allen-kh.cheng@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220419123331.14377-3-allen-kh.cheng@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 19/04/22 14:33, Allen-KH Cheng ha scritto:
> The SCP firmware blob differs between platforms and SoCs. We add
> support in the SCP driver for reading the path of firmware file from
> DT in order to allow these files to live in a generic file system
> (or linux-firmware).
> 
> The firmware-name property is optional and the code falls back to the
> old filename if the property isn't present.
> 
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> Reviewed-by: Rex-BC Chen <rex-bc.chen@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


