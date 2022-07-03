Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0851F5644BA
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 06:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230419AbiGCE15 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 00:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbiGCE14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 00:27:56 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 410CD655F;
        Sat,  2 Jul 2022 21:27:53 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id f85so2259916pfa.3;
        Sat, 02 Jul 2022 21:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=L3p41Hy2xkGcM9lCGDSD8Sj0lyHS0AKT+S1haQ42j0w=;
        b=oStd8z+n+zb6l9ZMlyH6Awr7moCoXrpFVl9kRQZqRF1yRtSvbrzlfYOz9ou79dOYDE
         0WMiLg+IdCvRY9OSJ9XgIp/sja810iXC9RBPPV8low9BTDfOZNZ9fmhEZMbPkBr9b+Nl
         6bVraWKUe2HVjSfTOrMafabo8tRn8ej5wMupGn/YaHV344k+wKKJ1V2ScYkncx0UoL3T
         RC5vxUtgaZ5XlMUpJSK+BAwueT3eH9COh4hM7Effx30Vdc88mYY2p9GTA+Ne5ZAp+lkt
         u2Ehhi8M3vgxvXiS69q8qOklA2/Vnleauomi75difO0lg6ymA5H/JE8itNk5RjvDT5FJ
         vxoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=L3p41Hy2xkGcM9lCGDSD8Sj0lyHS0AKT+S1haQ42j0w=;
        b=MezbvqlhkDb5JQPFon5AC7SWr5K18Cs0NDVceGr7m3XMKf4mcpf0NaUiNqZ0Lccu5V
         O0tgWDXKGuitBq3RNBzSaP/1STLX2HG612w+psjVYQSkNhu1/tw1fS5wWVGZTnXJKBeg
         Sc3KdG2lZBgJ9Gks2iE3i9GZXy9i9GD9Jr0O91IR9QjDyWsO/083olV+U1o6QPFCImtL
         7jxZdMPo6sRDp1VP8L5shl8B0ST0HE0vf2Cfja8hvx4W1oO8mXNIcwN1t1IJBhJViTB+
         xNmTO664UUsXub/FWN9tKJ1ZY5I3FVX6+HA2lVkNfZEe4P4kkdYXecQ0F23IdkiBNJ9T
         f26g==
X-Gm-Message-State: AJIora837diWVKhoFEkavu5REM9B8fs8dy4Ij+s8Df1xIyLwqk03eTlk
        RxNmluwFFH8AjntXlUE/29B/HSzZtac=
X-Google-Smtp-Source: AGRyM1u3Pvdf9wOoKvmkYRg+h459H+ro5MrXSf9xRirGQpvhD0gpDFNaHFDtfIGU9XUUG+Z40piC4A==
X-Received: by 2002:a63:4716:0:b0:410:ac39:868d with SMTP id u22-20020a634716000000b00410ac39868dmr18843643pga.347.1656822472792;
        Sat, 02 Jul 2022 21:27:52 -0700 (PDT)
Received: from [192.168.11.5] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id c13-20020a170902c1cd00b0016a276aada7sm18274477plc.20.2022.07.02.21.27.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Jul 2022 21:27:52 -0700 (PDT)
Message-ID: <abcaa4f5-7a9b-56b5-c11a-a88fef9d1e0a@gmail.com>
Date:   Sun, 3 Jul 2022 13:27:47 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: [PATCH] iio: proximity: sx9324: add empty line in front of bullet
 list
Content-Language: en-US
To:     Gwendal Grignou <gwendal@chromium.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Stephen Boyd <swboyd@chromium.org>, linux-doc@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        kernel test robot <lkp@intel.com>, linux-iio@vger.kernel.org
References: <202207021703.lEW6FLT1-lkp@intel.com>
 <85c5fe48-90fd-6ad6-72d8-a3e7929f23e4@gmail.com>
From:   Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <85c5fe48-90fd-6ad6-72d8-a3e7929f23e4@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"make htmldocs" emits a warning of:

    Documentation/ABI/testing/sysfs-bus-iio-sx9324:2: WARNING: Unexpected indentation.

This is due to a missing empty line in front of the bullet list.
Fix it.

Note: The line count of 2 in the warning is not exact in this case.

Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
Fixes: 4c18a890dff8 ("iio:proximity:sx9324: Add SX9324 support")
Link: https://lore.kernel.org/r/202207021703.lEW6FLT1-lkp@intel.com/
Reported-by: kernel test robot <lkp@intel.com>
Cc: Gwendal Grignou <gwendal@chromium.org>
Cc: Stephen Boyd <swboyd@chromium.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 Documentation/ABI/testing/sysfs-bus-iio-sx9324 | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-sx9324 b/Documentation/ABI/testing/sysfs-bus-iio-sx9324
index 632e3321f5a3..a8342770e7cb 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio-sx9324
+++ b/Documentation/ABI/testing/sysfs-bus-iio-sx9324
@@ -5,6 +5,7 @@ Contact:	Gwendal Grignou <gwendal@chromium.org>
 Description:
 		SX9324 has 3 inputs, CS0, CS1 and CS2. Hardware layout
 		defines if the input is
+
 		+ not connected (HZ),
 		+ grounded (GD),
 		+ connected to an antenna where it can act as a base
-- 
2.25.1


