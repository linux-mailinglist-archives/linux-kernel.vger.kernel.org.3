Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC7F9576FBE
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 17:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbiGPPTZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 11:19:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231975AbiGPPTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 11:19:20 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4368C1EC5A
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 08:19:17 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id g19-20020a9d1293000000b0061c7bfda5dfso5298936otg.1
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 08:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7IgaFb4FuhRx2DxLavmw65rYTf7cmqiILZlTWEaX0uw=;
        b=YiRFxedf5o0JAN7h35Ykz3sdcJq65iup8DS/ypasexgM2ice+9opoG5LhTg1tkiA+p
         YfCGWcPTXOqheW3wnT34IUzaagwvSL4sDWdRmMexRXFaNaB4rcNZO0Wiu8HORKhvdrGq
         7xmK7iCxepY+tQvnCemcqhRt4m0mfqhbLKi7Dh6zqLpT0C64an0OL5XjpgGnLR5itKZK
         28zr+4Lu4et+ma0gES470SYR5r9RSOSuwYNBmFSLbQVgMAofOiwvmdb8x7Ec63WJUKEa
         LI7/OBTsblwDNgqkqWk5O/zyOR/b+9QSfoyfuEYncOz9tIoQK38Jfivrm2J/ApYtsjre
         hbKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7IgaFb4FuhRx2DxLavmw65rYTf7cmqiILZlTWEaX0uw=;
        b=beSgnopq4Lgkmwpwi3R6cPmP4WEPizJlAWRNppmGO1dluuCQVUfzD4+vf7J3GE86FY
         qRu7MAxII+UuwLFjL3GfFSOXJk1Rf8iFFq0hnij+zZ3/it4P29qziiAYJK5UU04lz67J
         VgLKWka6HqshIJEZ8RA1LXv2TxQvU2I44lDXAAZNrUCFsMmiVztSR/FYoQlIvG9CtZt/
         koAbM+JuDLHbK8H3+4sJxXBzHvxb6uXbbhgmHV4T2tl09VaG/YUthJpVcb414q5eMEDw
         l4sVoadiWZ/gEMAdH4Sax5YkrA+FCZpKP9UKdK52bugK/PslxA0RTlcS9Eg7MPxp56wB
         onoQ==
X-Gm-Message-State: AJIora/y80Te0qiN/TO9/RIcW9wgZ9BiBAvdZOIQxtUHzo8TlPtDdCUf
        cGu4YDO5pCUcf2NLBOvO6SHmIg==
X-Google-Smtp-Source: AGRyM1vg6GXMhEmqUeh2b3amDDKy/lsMBhtNlC0nQjbHSfJeSNilFGk40KPo8kd2tRRMpoBcLnhlJg==
X-Received: by 2002:a05:6830:d8b:b0:616:97ed:18e5 with SMTP id bv11-20020a0568300d8b00b0061697ed18e5mr7862710otb.42.1657984756552;
        Sat, 16 Jul 2022 08:19:16 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id m21-20020a4ad515000000b00425beedad70sm3035254oos.32.2022.07.16.08.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Jul 2022 08:19:16 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Johan Hovold <johan+linaro@kernel.org>,
        Steve Capper <Steve.Capper@arm.com>
Subject: Re: (subset) [PATCH] arm64: dts: qcom: sc8280xp: Fix PMU interrupt
Date:   Sat, 16 Jul 2022 10:18:59 -0500
Message-Id: <165798474064.1679948.7724056255828690391.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220713143429.22624-1-manivannan.sadhasivam@linaro.org>
References: <20220713143429.22624-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Jul 2022 20:04:29 +0530, Manivannan Sadhasivam wrote:
> PPI interrupt should be 7 for the PMU.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: sc8280xp: Fix PMU interrupt
      commit: 39aa5646adae386719100e9e555a40e9db7bc4a2

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
