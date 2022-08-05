Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A701B58A75F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 09:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240254AbiHEHpQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 03:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236416AbiHEHpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 03:45:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03ED0120A7;
        Fri,  5 Aug 2022 00:45:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A04CEB82821;
        Fri,  5 Aug 2022 07:45:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 386F9C43141;
        Fri,  5 Aug 2022 07:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659685502;
        bh=NDP04/ybLf7TQXau1TKDwiOadCSU/e0nRJSMwJQTsf0=;
        h=From:To:Cc:Subject:Date:From;
        b=SGhzngVveegSUsi8l72fdnA1FBXRgyukx0lilmWJA+dAi5Ft0d1H3L31IrrNv9YSj
         qO3DtxZftR19/Wf35FD17Sl6c+BgFTbXQr/h42sRJzhvg2A2TalpxS6o8OVxiHZ3vW
         FTTd5sgFcrYNu4so7n24YVxCRWFKJ9OPOqjTEBb6scYRkrFYE+NvP5QlO5BDglUTpH
         BI1KOGDZa7WVcM94Ma7vNN8XLE1cukLODSYy+AkQSD4xH1LPdIEu/xWy4Ioutc0MwC
         AN4zOKd7jO9K08qqe8n1hiui06U2VbbupowVRPFikXUE4K+HBYtYmoe4vR47ETyRVs
         XDyWIjEbr2R8w==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1oJs1N-0005af-Tk; Fri, 05 Aug 2022 09:45:25 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 0/2] usb: dwc3: qcom: clean up icc init
Date:   Fri,  5 Aug 2022 09:44:58 +0200
Message-Id: <20220805074500.21469-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series clean up the interconnect-initialisation helper somewhat in
order to improve readability.

Johan

Johan Hovold (2):
  usb: dwc3: qcom: only parse 'maximum-speed' once
  usb: dwc3: qcom: clean up icc init

 drivers/usb/dwc3/dwc3-qcom.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

-- 
2.35.1

