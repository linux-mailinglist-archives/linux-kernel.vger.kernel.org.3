Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89FA15AC45B
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 14:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233582AbiIDM7f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 08:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbiIDM7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 08:59:30 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8987DEA6;
        Sun,  4 Sep 2022 05:59:28 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id k18so6697350lji.13;
        Sun, 04 Sep 2022 05:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=MaCiino+kPjk0mzeLjaGzc7ngCKP9nbk7eUckZ209Uc=;
        b=nGmzIqyW8Gkt2mTsg3NQcRYeGgZXxAFa0SKkwwbtnDhOav/cvEu3IEgIS5XEWAujOc
         ckBTBJ+9zEbtTbV0nmLx99sKsvVsIbVQuOxq9SgTHxVuvgcfm9i9UwZQm7hIQFx6otRJ
         eVvoLDVBHXxQSmVg2U3fSE+lQYqe35iSj5dsJqgbrFqod/6dyxRb36Aav+p1G7BfZjS1
         ipvEWGJDjk3RtOsB29GEL5phjWhVZxU7G2yvnb5K0pme2LJpPlud4Slnk+iAYG+XXJok
         7NDF42stOftqkhA7YNClQZCjL60ASc+gWIXZi2ikDYdmdO6t2uiRUL+QU++1cWVOUtJd
         TbxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=MaCiino+kPjk0mzeLjaGzc7ngCKP9nbk7eUckZ209Uc=;
        b=TN1EC2+DFi2v3VsmI6oUKvsDG0iLP7B0Ykim9n7iohdXYKtOLQJEouN6CU8b2sNBLz
         8U0sIqx3A84bX7jJUYOdQxUWjfgAy3nGq+zn4LwnG6fqFkdhHHIeXknopu0YIS5+kuYW
         pm8hprsAtefK2alaqQua2L4w46UKBYkbF9ZBEdZVFQdU/KLKN4s1obDKVHY501i/nuFC
         VZTDXae1UtQ/orMcUam6HBrMA/+fO1cLW7fA7Jw0YkByLi/m6H1rDZGhNClla8Swh737
         kw7c0xJE0mYc2LGHiUtqlQodxJwRWU2WLSeeuyGgddj4KBJqr3R+fYEi5g+HI/196lcc
         meIw==
X-Gm-Message-State: ACgBeo3O6GH1Sa+3XBleSNpG5Cgoj68WocC0i9A37CwOe+j626yCKC5/
        NveYRNU3neIgAbiuqqyWVtkL1J7ylFI=
X-Google-Smtp-Source: AA6agR7oDNcqN4n23e8Kl3aqZxtaX3bou67PPbdyBcJiiFNQKq37CjJs3UzaOWRhwQ3dpvALHXbedQ==
X-Received: by 2002:a2e:b892:0:b0:25f:db66:3b86 with SMTP id r18-20020a2eb892000000b0025fdb663b86mr14179513ljp.79.1662296367003;
        Sun, 04 Sep 2022 05:59:27 -0700 (PDT)
Received: from [192.168.2.145] ([109.252.119.13])
        by smtp.googlemail.com with ESMTPSA id x17-20020ac259d1000000b004947e89ae4bsm888951lfn.294.2022.09.04.05.59.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Sep 2022 05:59:26 -0700 (PDT)
Message-ID: <af23462c-2d3b-470a-7fd6-2bf09a3174cb@gmail.com>
Date:   Sun, 4 Sep 2022 15:59:25 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v17 00/10] Add MT8195 DisplayPort driver
Content-Language: en-US
To:     Bo-Chen Chen <rex-bc.chen@mediatek.com>, chunkuang.hu@kernel.org,
        p.zabel@pengutronix.de, daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mripard@kernel.org,
        tzimmermann@suse.de, matthias.bgg@gmail.com, deller@gmx.de,
        airlied@linux.ie
Cc:     devicetree@vger.kernel.org, linux-fbdev@vger.kernel.org,
        granquet@baylibre.com, jitao.shi@mediatek.com,
        liangxu.xu@mediatek.com, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, msp@baylibre.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-mediatek@lists.infradead.org, wenst@chromium.org,
        linux-arm-kernel@lists.infradead.org,
        angelogioacchino.delregno@collabora.com
References: <20220901044149.16782-1-rex-bc.chen@mediatek.com>
From:   Dmitry Osipenko <digetx@gmail.com>
In-Reply-To: <20220901044149.16782-1-rex-bc.chen@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

01.09.2022 07:41, Bo-Chen Chen пишет:
> This patch is separated from v10 which is including dp driver, phy driver
> and dpintf driver. This series is only contained the DisplayPort driver.
> 
> This series can be tested using 5.19-rc2 kernel and I test it in MT8195
> Tomato Chromebook. Modetest these modes:

Applied to drm-misc-next, thanks!
