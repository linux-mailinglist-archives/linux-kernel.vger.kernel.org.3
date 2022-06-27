Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CE9355CB49
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237378AbiF0O63 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 10:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237147AbiF0OwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 10:52:25 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5D7B414089;
        Mon, 27 Jun 2022 07:52:21 -0700 (PDT)
Received: from [192.168.100.8] (unknown [112.20.112.134])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9DxT0wUxLliSxxgAA--.6493S3;
        Mon, 27 Jun 2022 22:52:05 +0800 (CST)
Message-ID: <0ebe206c-61d6-d39a-8ad7-bc53a1094405@loongson.cn>
Date:   Mon, 27 Jun 2022 22:52:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 03/20] docs: zh_CN: page_frags.rst: fix a broken
 reference
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Alex Shi <alexs@kernel.org>, linux-kernel@vger.kernel.org
References: <cover.1656234456.git.mchehab@kernel.org>
 <a12e18044ddb2ca16a1fed10823d59558d6de405.1656234456.git.mchehab@kernel.org>
From:   YanTeng Si <siyanteng@loongson.cn>
In-Reply-To: <a12e18044ddb2ca16a1fed10823d59558d6de405.1656234456.git.mchehab@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9DxT0wUxLliSxxgAA--.6493S3
X-Coremail-Antispam: 1UD129KBjvdXoWrKF1DKF4kCryrJrWUJF47Arb_yoWDKrb_Za
        1kJFWrAF1Dt34xKw48GF1xJr40vFWFkr18JryDt3yrK3WjqrZ8Was2q3sYvas8Xws3uFn8
        K3ykXwsayrnrtjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbI8YjsxI4VWxJwAYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I
        6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
        8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0
        cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z2
        80aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAK
        zVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx
        8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21lc2xS
        Y4AK67AK6ry5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
        8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWU
        twCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
        0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AK
        xVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvj
        xU2rgAUUUUU
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
> 	page_frag.rst -> page_frags.rst
>
> Fixes: f51debc256f8 ("docs/zh_CN: add vm page_frags translation")
> Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>

Acked-by: Yanteng Si<siyanteng@loongson.cn>

Thanks,
Yanteng

> ---
>
> To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
> See [PATCH v2 00/20] at: https://lore.kernel.org/all/cover.1656234456.git.mchehab@kernel.org/
>
>   Documentation/translations/zh_CN/vm/page_frags.rst | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/translations/zh_CN/vm/page_frags.rst b/Documentation/translations/zh_CN/vm/page_frags.rst
> index ad27fed33634..38ecddb9e1c0 100644
> --- a/Documentation/translations/zh_CN/vm/page_frags.rst
> +++ b/Documentation/translations/zh_CN/vm/page_frags.rst
> @@ -1,4 +1,4 @@
> -:Original: Documentation/vm/page_frag.rst
> +:Original: Documentation/vm/page_frags.rst
>   
>   :翻译:
>   

