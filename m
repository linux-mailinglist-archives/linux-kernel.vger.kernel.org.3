Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 464FD4F1056
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 09:53:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356273AbiDDHzg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 03:55:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233822AbiDDHze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 03:55:34 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFB8B60EA
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 00:53:38 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id u3so13151735wrg.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 00:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Va1uiLP023t5MihYO/Flcr7OZNL1vNKKp5c2ZjT5AYw=;
        b=VNyJRcdNveWkpMXVdciF4KakpZiiW50ocgP5YSME8fh3xUgRcRBcJU/rD+Wnfdxx7A
         Y7ikB5gYpemDjSLgjNyMpJ2cUbHrIADnCRs7A4HChUxwDg4Pi7+7Jfo6PVhYLmpQYnVC
         BOT9OCrzMtsF8hBQlkAjpG7/k5lQj0+JRYDfjIqkiwquBvj18clVBVISCvycxJchL9o5
         aqk4YZPSZXPIfDGcudm87F4kqJClWQ2dfU9noSroszqA1FARCGGehMpA+Hi8RVolfeX+
         OxU/jOSla+tZI4ohJ6j/bPmNuBGO3c8WsNOU2T1J0Fhg+v6cjONZW7rMVSpJYyXaIL1u
         k3Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Va1uiLP023t5MihYO/Flcr7OZNL1vNKKp5c2ZjT5AYw=;
        b=mz2io0y2wrXSbsBwZao49we2CmEsbaUS8uvAGcxEjKb78iyO9iYj20QglGLlanJHQQ
         wxTsST+juXds3Ehto0pd/PIsI89Pvs5/lsrYzSWKYuN9L3A5QMj7SzE0En1OY/waR/Xj
         T9gUqMjN4xREA/Ubbqw4y/qa7kxtjXLpKpJ2DKGMM5ozcajGrwfKw3Z6fh/xM/8okluc
         422LcSVOtVay2T1yuBT5S60NGinAdbq+atWtpRRQrs9jEVQDnF9aDCNAL61jInGsqj9h
         kG4ClWzPr4Hu3etKOIhz1kwfZBrzxHx7ubG+9qXeFh49fNlJkAPYeRUk8GuOxIsNF5Cd
         thmg==
X-Gm-Message-State: AOAM533GSAIbDeR8tSV+bkDGEHGcJb17q2kwdUUg6kD8oXUxkvtU/LBY
        MAfVnZanaVbhYPq/0LQA/fOIAA==
X-Google-Smtp-Source: ABdhPJzs9+un4qKZIQaAzrww2f9CT3skrXSwzLMlgxxyZ9AMGMUBwhl0FAI8l0Ot7SRoZMVhtPZDyw==
X-Received: by 2002:adf:cd11:0:b0:206:1108:ebc1 with SMTP id w17-20020adfcd11000000b002061108ebc1mr2878589wrm.33.1649058817433;
        Mon, 04 Apr 2022 00:53:37 -0700 (PDT)
Received: from localhost.localdomain ([2001:861:44c0:66c0:1add:1b28:2457:eb46])
        by smtp.gmail.com with ESMTPSA id a1-20020a056000188100b002041a652dfdsm8510186wri.25.2022.04.04.00.53.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 00:53:36 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     linux-arm-kernel@lists.infradead.org,
        Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Christian Hewitt <christianshewitt@gmail.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCH v2 0/2] arm64: dts: meson: remove CPU opps below 1GHz for G12B/SM1
Date:   Mon,  4 Apr 2022 09:53:35 +0200
Message-Id: <164905879796.1795914.1262665444857869291.b4-ty@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220210100638.19130-1-christianshewitt@gmail.com>
References: <20220210100638.19130-1-christianshewitt@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 10 Feb 2022 10:06:36 +0000, Christian Hewitt wrote:
> Amlogic G12B and SM1 devices experience CPU stalls and random board
> wedges when the system idles and CPU cores clock down to lower opp
> points. Recent vendor kernels include a change to remove 100-250MHz
> (with no explanation) [0] but other downstream sources also remove
> the 500/667MHz points (also with no explanation). Unless 100-667Mhz
> opps are removed or the CPU governor forced to performance, stalls
> are observed, so let's remove them an improve stability/uptime.
> 
> [...]

Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (v5.18/fixes)

[1/2] arm64: dts: meson: remove CPU opps below 1GHz for G12B boards
      https://git.kernel.org/amlogic/c/6c4d636bc00dc17c63ffb2a73a0da850240e26e3
[2/2] arm64: dts: meson: remove CPU opps below 1GHz for SM1 boards
      https://git.kernel.org/amlogic/c/fd86d85401c2049f652293877c0f7e6e5afc3bbc

-- 
Neil
