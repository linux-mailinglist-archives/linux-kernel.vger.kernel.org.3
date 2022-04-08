Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 302044F96F9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 15:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236374AbiDHNj4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 09:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236402AbiDHNj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 09:39:26 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FB9D23D5B2;
        Fri,  8 Apr 2022 06:37:16 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 537431F47188
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1649425035;
        bh=Oofbdw+DqrbQDCnknn+6kDsqU6P4e3dcJAg3gndJN9Q=;
        h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
        b=W22+8vnwBDWrzaF/WLy1PPevdxj9XGdow2NL4TsRviA2vGMD7rvxeFZ5I7/1DwxhB
         3pXABJDAIr1lQMDYhUEHOb8ME1wQOZGwyprmTlCTze/UUNeQFEr7xlKeeGbF+ZXgP7
         +amN+o/dLOLK1dbC3XIdE9S3XSoTv0h9eR2MFy7H5vD9X5J2z0t1/8HSVVY7lgrbYg
         otp9zER/Ivs9C4qYcMg6t9MqEn52vORP2hWGxjy2WnlQj9lCRlWBLANKNvUxconRci
         e7TlfQyl5Pq//4LMjDdmP0zX4zlk8wm2etSTKYlhcQun4c090Ux4ccKlXhAwdkE53w
         0D+NxRns4X9RQ==
Message-ID: <88fac11e-e8a2-743f-41af-7b7e9e0fdfd3@collabora.com>
Date:   Fri, 8 Apr 2022 15:37:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH V2 15/15] cpufreq: mediatek: Use device print to show logs
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>, rafael@kernel.org,
        viresh.kumar@linaro.org, robh+dt@kernel.org, krzk+dt@kernel.org
Cc:     matthias.bgg@gmail.com, jia-wei.chang@mediatek.com,
        roger.lu@mediatek.com, hsinyi@google.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220408045908.21671-1-rex-bc.chen@mediatek.com>
 <20220408045908.21671-16-rex-bc.chen@mediatek.com>
Content-Language: en-US
In-Reply-To: <20220408045908.21671-16-rex-bc.chen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 08/04/22 06:59, Rex-BC Chen ha scritto:
> Replace pr_* with dev_* to show logs.
> 
> Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>

That's very appreciated.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

