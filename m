Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD88F55DB0D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:24:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236817AbiF0OzM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 10:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236814AbiF0OzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 10:55:08 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 78CB215FE4;
        Mon, 27 Jun 2022 07:55:04 -0700 (PDT)
Received: from [192.168.100.8] (unknown [112.20.112.134])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dxf9jFxLlisxxgAA--.8903S3;
        Mon, 27 Jun 2022 22:55:02 +0800 (CST)
Message-ID: <b37810de-7767-67b5-b7a7-15ba2e48324a@loongson.cn>
Date:   Mon, 27 Jun 2022 22:55:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 08/20] docs: zh_CN/vm/zsmalloc.rst: fix a typo
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Alex Shi <alexs@kernel.org>, linux-kernel@vger.kernel.org
References: <cover.1656234456.git.mchehab@kernel.org>
 <25a9fff20d39a6638b8a7c0fefa0767e77d96dec.1656234456.git.mchehab@kernel.org>
From:   YanTeng Si <siyanteng@loongson.cn>
In-Reply-To: <25a9fff20d39a6638b8a7c0fefa0767e77d96dec.1656234456.git.mchehab@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9Dxf9jFxLlisxxgAA--.8903S3
X-Coremail-Antispam: 1UD129KBjvdXoW7Wr4UGw4DWw4rAw48WryxAFb_yoWDuFb_Ca
        1kJF4F9Fyqyr1ktF4fGFs7Gw1jyr4FkF18ta4Dt3y3G3WUKF4kWa4kWwnYy3W3JwsruF15
        CFZ7Xrn3trnFqjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbxkYjsxI4VWxJwAYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I
        6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
        8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0
        cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z2
        80aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAK
        zVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Gr0_Cr1lOx
        8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21lc2xS
        Y4AK67AK6ry5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
        8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWU
        twCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
        0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Gr0_Zr1lIxAIcVC2z280aVAFwI0_
        Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8
        knY5UUUUU==
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2022/6/26 17:10, Mauro Carvalho Chehab 写道:
> typo:
> 	zs_malloc.rst -> zsmalloc.rst
>
> Fixes: 6dbc3a5bdb46 ("docs/zh_CN: add vm zsmalloc translation")
> Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>

Acked-by: Yanteng Si<siyanteng@loongson.cn>

Thanks,
Yanteng

> ---
>
> To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
> See [PATCH v2 00/20] at: https://lore.kernel.org/all/cover.1656234456.git.mchehab@kernel.org/
>
>   Documentation/translations/zh_CN/vm/zsmalloc.rst | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/translations/zh_CN/vm/zsmalloc.rst b/Documentation/translations/zh_CN/vm/zsmalloc.rst
> index 29e9c70a8eb6..45a9b7ab2a51 100644
> --- a/Documentation/translations/zh_CN/vm/zsmalloc.rst
> +++ b/Documentation/translations/zh_CN/vm/zsmalloc.rst
> @@ -1,4 +1,4 @@
> -:Original: Documentation/vm/zs_malloc.rst
> +:Original: Documentation/vm/zsmalloc.rst
>   
>   :翻译:
>   

