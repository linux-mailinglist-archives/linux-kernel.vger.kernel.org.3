Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDA345A5808
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 01:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbiH2XtB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 19:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbiH2XsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 19:48:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4082AA8302;
        Mon, 29 Aug 2022 16:47:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 48BF3B815A1;
        Mon, 29 Aug 2022 23:46:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 815A7C433D7;
        Mon, 29 Aug 2022 23:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661816807;
        bh=5W8nXJQsvwqgoO60z9z+SKF9VBbExPRmhz/4m2f9dIc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bP4rS8Qb5QR1szW7fVMHoFB+eV6BlPsBQpXXVoQRVCEQoPhZlQyhRvgdK8Ef9aghb
         fg+JNiXbGxvKQ6LrmjoXL2oWqIV4KUV1hCBr2SimNdNNr9f/gAWLK+vYXGRWCN6iBC
         xx0nNvxN345Xf2GakmtrorLgtVQx4ZuFzc2Q4lFQ6w3ehPGK5i+2DfH3A1L7ox9R17
         J4zxDkQwURymASdCnQBPP+juU0tod67CA10MOl3m1pP3iVLAdHA2t+Y9Ikx5eT6dH8
         bcRRuwTKsGfGWdirhcaViKYtyf1idSkwdtDh8eJPM3sRSVJI69tDH8M/qAgXuB8XOo
         AeOwjyXm0/wBQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Bjorn Andersson <andersson@kernel.org>,
        konrad.dybcio@somainline.org, agross@kernel.org,
        quic_jjohnson@quicinc.com
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        lkp@intel.com
Subject: Re: [PATCH v2] soc: qcom: qmi: use const for struct qmi_elem_info
Date:   Mon, 29 Aug 2022 18:46:09 -0500
Message-Id: <166181675992.322065.17670485769129008263.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220822153435.7856-1-quic_jjohnson@quicinc.com>
References: <20220822153435.7856-1-quic_jjohnson@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Aug 2022 08:34:35 -0700, Jeff Johnson wrote:
> Currently all usage of struct qmi_elem_info, which is used to define
> the QMI message encoding/decoding rules, does not use const. This
> prevents clients from registering const arrays. Since these arrays are
> always pre-defined, they should be const, so add the const qualifier
> to all places in the QMI interface where struct qmi_elem_info is used.
> 
> Once this patch is in place, clients can independently update their
> pre-defined arrays to be const, as demonstrated in the QMI sample
> code.
> 
> [...]

Applied, thanks!

[1/1] soc: qcom: qmi: use const for struct qmi_elem_info
      commit: ff6d365898d4d31bd557954c7fc53f38977b491c

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
