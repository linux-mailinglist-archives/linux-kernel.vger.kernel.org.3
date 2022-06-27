Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D0D155CAD3
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240860AbiF0UDb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 16:03:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240778AbiF0UDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 16:03:19 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00AE81A042
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 13:03:18 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id w2-20020a056830110200b00616ce0dfcb2so2880702otq.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 13:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ItqEu+lAWFywVj/7Sp4uH56FVniAGH7QFEwGCURs750=;
        b=qpbOrnDDCSeOTeUMMOhi/+Gpih7IavGKBdKTPC996619XvZLRfxMFfNKZtkid3rx2s
         fPMqtC0JQoyPri1hKDi6yW7F/q/mmD08m3hZXctogXAvxK7CBO+FuvMTVCoin5dp9eom
         qvgO48HC/f1cZwRr3agSIoyIIL7jXP4haenUVQtMg7rk28yPnl6YhlE7NwAuk9cz47gf
         c8Nq30XFxhIzhszThIuYS6dEGz65hFw0oGzgjcDplwd9qlkrkrUf8qtKntDDTQqiLcei
         5ZCG46tvZGNCMagZO+HIEKOjb01uQAj/1SclumYWb0Se90Y5k1mRyStBOwosbWJqi6pY
         SukA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ItqEu+lAWFywVj/7Sp4uH56FVniAGH7QFEwGCURs750=;
        b=5ytlT9N+2XD+DfIBqENsQheCk65RF97bQWYn0miwWX2XnF+4pmsK7xNSOttPuWhFab
         bsVUGNngUkh4ohHMmqgSY1t54gZ7NL6P5ZqPHHtD22nqHnooExFzgTGuRtDSMtjMqtwg
         Y2mx/VwrTphUbbmo7flupi7pG1EPoR1nDHaxJ3ouJWxnH0olsL8hYdvzuD/nILe0V6Cm
         /lYW3l3V/LKj1hfbHOvFxUNnwZjdOFAF3nKR/XL6+echdnZ9GECZXefvDFWPsiXO/otm
         1Hxr0eqedbLKEezCW/0XuiRKDIAuXxWCWMzyfWT+qADV9UnyoRCI8oUQb7YkNb/T6cW1
         2h8w==
X-Gm-Message-State: AJIora9yNmzolFC77nQriEn7XU/hky4HZ0CAMgIkyIRzrBNlyudRUCmP
        BwshgMANEmbpKhE8B1SJc9GX6H/1OHPS0A==
X-Google-Smtp-Source: AGRyM1uZjewcPz1q7uEbPg0Nk6kk17VoeOQhYespe3p3jGWG44ifdwVQS65I00wjnjaMborxq/j3rg==
X-Received: by 2002:a05:6830:6516:b0:614:d633:8b9a with SMTP id cm22-20020a056830651600b00614d6338b9amr6457412otb.137.1656360198251;
        Mon, 27 Jun 2022 13:03:18 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id m16-20020a4a9510000000b0041bdf977c6dsm6428729ooi.31.2022.06.27.13.03.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 13:03:17 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Douglas Anderson <dianders@chromium.org>,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        matvore@chromium.org, Andy Gross <agross@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>
Subject: Re: (subset) [PATCH v3] soc: qcom: socinfo: Add an ID for sc7180P
Date:   Mon, 27 Jun 2022 15:02:39 -0500
Message-Id: <165636016347.3080661.11368001720445085919.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220523085437.v3.1.I26eca1856f99e6160d30de6d50ecab60e6226354@changeid>
References: <20220523085437.v3.1.I26eca1856f99e6160d30de6d50ecab60e6226354@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 May 2022 08:54:57 -0700, Douglas Anderson wrote:
> Some sc7180 Chromebooks actually have sc7180P (known by many names,
> apparently, including possibly sc7180 Pro and sc7185). This is a
> sc7180 part that has slightly higher clock speeds.
> 
> The official ID number allocated to these devices by Qualcomm is 495
> so we'll add an entry to the table for them. Note that currently
> shipping BIOS for these devices will actually end up reporting an ID
> of 407 due to a bug but eventually a new BIOS will be released which
> corrects it to 495.
> 
> [...]

Applied, thanks!

[1/1] soc: qcom: socinfo: Add an ID for sc7180P
      commit: 0f0eca0ccb9b37743466fbd1b388a04ea0307b89

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
