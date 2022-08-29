Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A43A5A5822
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 01:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbiH2Xrv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 19:47:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbiH2XrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 19:47:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D216A6C30;
        Mon, 29 Aug 2022 16:46:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E37C3B815C6;
        Mon, 29 Aug 2022 23:46:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C0FAC4347C;
        Mon, 29 Aug 2022 23:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661816808;
        bh=w3QGP3QwMPeUPT6nfHCPCvAmzXw/tWqsdz3iVKu+JeY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b0ZPMVJMQMnvSdIjYZz87sjCLc8kr5pU8EFzjpVCuTT9AH9zhYSsY7HJPxiR9pyhs
         eNYW3n8wwtCHKlvwpzJpoNPuCp+2j4EbI43o1szxGf9ou5sP+/lZ7J4PNonaStKzR7
         FVhFbgHgBO5YEh8KY1r7MmLcdvZngRU2M71w3KufbTPYBONRQ/18+o3SiiF/qun0jZ
         fUwr+RUoEb29AIgXzwqKziRYNWKBtK0+XuOw9jNaYgg7i7ue0D6r1X83kNl3/TRgk9
         zU9CiW2SCT7li7/F+c2V9U+uD18N/JKrJRD6OUPKiVdgSKIhp+QmCvwQZY9UndiHJc
         L2ioMR/1Vv7WA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Bjorn Andersson <andersson@kernel.org>, agross@kernel.org,
        swboyd@chromium.org
Cc:     mka@chromium.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH] arm64: dts: qcom: sc7180-trogdor: Keep pm6150_adc enabled for TZ
Date:   Mon, 29 Aug 2022 18:46:11 -0500
Message-Id: <166181675988.322065.7864125729099787019.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220827004901.511543-1-swboyd@chromium.org>
References: <20220827004901.511543-1-swboyd@chromium.org>
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

On Fri, 26 Aug 2022 17:49:00 -0700, Stephen Boyd wrote:
> There's still a thermal zone using pm6150_adc in the pm6150.dtsi file,
> pm6150_thermal. It's not super obvious because it indirectly uses the
> adc through an iio channel in pm6150_temp. Let's keep this enabled on
> lazor and coachz so that reading the temperature of the pm6150_thermal
> zone continues to work. Otherwise we get -EINVAL when reading the zone,
> and I suspect the PMIC temperature trip doesn't work properly so we
> don't shutdown when the PMIC overheats.
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: qcom: sc7180-trogdor: Keep pm6150_adc enabled for TZ
      commit: 144fbd028fdec2deeb3b99d5e60dbf3167950ebe

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
