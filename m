Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5D2C473DBD
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 08:38:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231484AbhLNHir (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 02:38:47 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:53424 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231233AbhLNHiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 02:38:46 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D9242B8172C;
        Tue, 14 Dec 2021 07:38:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D416AC34601;
        Tue, 14 Dec 2021 07:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639467523;
        bh=LYVbEp6oDnQQyqbRxWbmjublt79R3Y2q0XjQOAruDPo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GmMBhJUGo6F6Qe4ZRZt1z3TfBX33FlvvhhmwITzLoGqwtZIz/tDVjFZv2qB8CV2Ou
         JXbCY22GdcGxDWBiAVY69uF3lwz9bbnJT/q583DFkwYzRw5TuMmCZjDvWXqOS3OBiQ
         v4OqOKTEDUXqGR5Pr6fOax2Fu2ju4eHtojgiXlWXnCWMlnYV0o7Y+/AuSufy2cJ1hJ
         sbaTjprawXUxoieIcBJ7+nRhJs6KGmGJfwuoa0rorIrs113da/IT4fh6EKuyNSvsZe
         HJdFR4CeExfxWd5nNR0z9knZ4Atrq9Gr+KkW/Nth5rOWAXzgFG3+kSEssQq/HElZdh
         5K1vaq0P+CvwQ==
Date:   Tue, 14 Dec 2021 13:08:39 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Luca Weiss <luca.weiss@fairphone.com>
Cc:     linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Manu Gautam <mgautam@codeaurora.org>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/10] dt-bindings: phy: qcom,qusb2: Add SM6350 compatible
Message-ID: <YbhJ/zNI8EgD15TN@matsya>
References: <20211213082614.22651-1-luca.weiss@fairphone.com>
 <20211213082614.22651-5-luca.weiss@fairphone.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211213082614.22651-5-luca.weiss@fairphone.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13-12-21, 09:26, Luca Weiss wrote:
> Add devicetree compatible for the usb phy on SM6350 SoC.

Applied to phy-next, thanks

-- 
~Vinod
