Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59FF14B8CA9
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 16:41:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235562AbiBPPmD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 10:42:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230491AbiBPPmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 10:42:01 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC21A13F34;
        Wed, 16 Feb 2022 07:41:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B4D3461A0C;
        Wed, 16 Feb 2022 15:41:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE600C004E1;
        Wed, 16 Feb 2022 15:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645026107;
        bh=rIvI7RHN7VOk5k6Knj5isUnfKRnIoIua2chTqpLtNMY=;
        h=From:To:Cc:Subject:Date:From;
        b=ObYB7N1U6ZNVSlWbGgsfnEjxEACv+QQo4sBUXVEnmYXC0XoG16edxefvJJkuSHBky
         JbYNXHb7X/IG96+PsGoZ1NDE6/zzxqaDTFSp8TE1yCkOSg6taK+cdM8GWnn658DTZv
         PG7dSIFCmP7aL7orFFm+aS1ShbO8g82FHnxiIV3VORXzqEY33pvxk+hjX1k0YdoU89
         yKkClR1a1rvmDeWMlTfR/AvSEMQIZXV0aJQ5pAzSoUY+sFI/VZIwxVik/gcWvF/+Nm
         +9AKIPcsCmFydGTxv/2oTnk0HfgN1RAj20QqTs37cwUbiGJ7VNtOlrajjVdkuCHhFe
         mXu7wInWmz6HQ==
From:   Nathan Chancellor <nathan@kernel.org>
To:     cgel.zte@gmail.com
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        chi.minghao@zte.com.cn
Subject: Re: [PATCH] soc/qcom: use struct_size over open coded arithmetic
Date:   Wed, 16 Feb 2022 08:41:19 -0700
Message-Id: <20220216154119.240072-1-nathan@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am forwarding along this build report from the kernel test robot due
to a bug in their system. As I am sure you will figure out soon enough,
this patch was not even build tested.

Cheers,
Nathan
