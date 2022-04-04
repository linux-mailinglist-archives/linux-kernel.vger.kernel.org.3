Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61B8C4F1187
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 11:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343885AbiDDJCH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 05:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245160AbiDDJCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 05:02:04 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3542229C91;
        Mon,  4 Apr 2022 02:00:09 -0700 (PDT)
Received: from wf0416.dip.tu-dresden.de ([141.76.181.160] helo=phil.dip.tu-dresden.de)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1nbIZA-0008Ew-8w; Mon, 04 Apr 2022 11:00:04 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
        krzk+dt@kernel.org, robh+dt@kernel.org,
        linux-rockchip@lists.infradead.org, vkoul@kernel.org,
        linux-arm-kernel@lists.infradead.org, yifeng.zhao@rock-chips.com,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        kishon@ti.com
Subject: Re: [PATCH v9] dt-bindings: soc: grf: add naneng combo phy register compatible
Date:   Mon,  4 Apr 2022 10:59:56 +0200
Message-Id: <164906273050.1398682.6515580602409136621.b4-ty@sntech.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220324120122.1339-1-jbx6244@gmail.com>
References: <20220324120122.1339-1-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Mar 2022 13:01:22 +0100, Johan Jonker wrote:
> Add Naneng combo phy register compatible.

Applied, thanks!

[1/1] dt-bindings: soc: grf: add naneng combo phy register compatible
      commit: a66f6482f8f1669209812cd6fa991c3774ce1d02

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
