Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 299815060FD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 02:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240807AbiDSAk4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 20:40:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237339AbiDSAkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 20:40:51 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ECC827163
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 17:38:11 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id n11so12122396qvl.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 17:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject
         :content-language:to:disposition-notification-to
         :content-transfer-encoding;
        bh=O/39KxrjTXbMZLJDhwPEa021aH0kdwg1Gk5HnjEQ3Lc=;
        b=mecdPxcV4TufZjm9BbdVXBneOupw2sAgoxtSwZDKRn1VtGzUHoySXsqMA9T+2oEc+p
         LwAhUfeW7pCCe40QpjtuarH0D36GseLRDmcHKnKbzI3e/OkSHQRZOp3WSFWxfXNOq1we
         iZQr67/RQf4Swxh87Yxi/jXQ4KM1gJcrri2NhaiE4gi8gyiw9R3gJZPYf8V1bJ7uKCaw
         yp3g0pQTUnLo3hjzz1BBx44wSJDLv5ifHf/fjaSUpw0W/oT9X65Vdvp1lC4Kvs1vI4Mc
         kku9VUHCctsE9YtGdh2r7+ur3UBkxCugXr69LYSkI2Ph+oaBh9W7JZu9N4vFfX1oxXFK
         6/GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:content-language:to:disposition-notification-to
         :content-transfer-encoding;
        bh=O/39KxrjTXbMZLJDhwPEa021aH0kdwg1Gk5HnjEQ3Lc=;
        b=YrzF1TGDRoWjyBqOs0g9rCZScm5KDYxV/ZmKW7TjYk4sCSD1t4ySG6IWftuaYCmpHn
         pCjer94mV3cgVINomhf7TggCLd7+RmGVVDaQ3h2D8XWN89dbVmI7QMtoseU52jK86Iwd
         WhDffTCIGtt841KbnoMJxScbibLuhoxPKaeGkg/rMGFJhumAqh+nksIUUs0X5hm71dt7
         z62DbArzjBVbNTKziBxjLzDHto4yzLl+Kae+vkgJy2aPCO48cofEX/7DT3K3uXN5HpNv
         qHdjYn89Rstb+zw1lVBrThLxYIV7XX2pj49wKdqYq+pWf6IKv0Qe9bJ1MCjUTYCMsfYq
         Ng7A==
X-Gm-Message-State: AOAM531aFZV3qq0yJBbPd1VJx5567C6OBR7ro5waev9j5LeLKnXBlNvg
        TD4qGMNSSCu2cfh3HJmH/CXEV2LpwVs=
X-Google-Smtp-Source: ABdhPJwDiXqTPBGp2xXIty64QcYZJEm8BMoLLJvIfPxLfZ/DLTwIb9cGc3k4f9BhmS01ORzPFUa0Hg==
X-Received: by 2002:a05:6214:5089:b0:446:6576:95bd with SMTP id kk9-20020a056214508900b00446657695bdmr3642294qvb.61.1650328690469;
        Mon, 18 Apr 2022 17:38:10 -0700 (PDT)
Received: from [10.1.1.117] (pool-71-121-149-202.bltmmd.fios.verizon.net. [71.121.149.202])
        by smtp.gmail.com with ESMTPSA id p5-20020a378d05000000b0069beaffd5b3sm7606413qkd.4.2022.04.18.17.38.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Apr 2022 17:38:10 -0700 (PDT)
Message-ID: <5ae22b2e-97de-6680-50a3-887ab87b3b87@gmail.com>
Date:   Mon, 18 Apr 2022 20:37:51 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:100.0) Gecko/20100101
 Thunderbird/100.0
From:   hanasaki-gmail <hanasaki@gmail.com>
Subject: kernel LAN : Intel 2.5GbE LAN : support
Content-Language: en-US
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        GB_FREEMAIL_DISPTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kernel LAN : Intel 2.5GbE LAN  : support
Intel 2.5GbE LAN chip (2.5 Gbps/1 Gbps/100 Mbps)

Looking at the below motherboard.
what .config option and kernel module supports
this ethernet LAN chip and at 2.5GB?

What is the first kernel version having support?

ref:
X570SI AORUS PRO AX (rev. 1.1)
https://www.gigabyte.com/us/Motherboard/X570SI-AORUS-PRO-AX-rev-11
