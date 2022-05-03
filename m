Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF38519057
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 23:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243059AbiECVlZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 17:41:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236860AbiECVlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 17:41:20 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01F5641620;
        Tue,  3 May 2022 14:37:46 -0700 (PDT)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 3FF01FF808;
        Tue,  3 May 2022 21:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1651613865;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NhV8JO6n5kXC88f/zTARxclvqaIyYVSq6FOpYLYky8o=;
        b=fbn7gJBRVgchh9RqK1mewr0qO2yK6P867EdZyCSrdIZiV8mMMvTdtjngyUPyNlzURJeZnv
        nUwE1yBWioW8C/kyMI8BN8rTCUikQnhZmL/2x8PZpJoKdPuz2rQJUKAJjXSp2CbsfmJOrf
        kb1KzbAe0nPesUPmJe3sgFoAhpcPosez/5Ep5uueO8Kfd6+OvAuXTzTUsFR1DAu03wZsLn
        zyQHC0RtB3wtaeWcAaUinKR/o/70h0xBFFiY+8W5HlzqwWXUmzltEDXiS0OwsWrckH409K
        /qoCFLUNN47Y4h0KpGmhDexWn+GQ/6QVpDuNK87gWVoz/3By3iK5DyedsuzN4w==
From:   alexandre.belloni@bootlin.com
To:     Vitor Soares <vitor.soares@synopsys.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh@kernel.org>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-i3c@lists.infradead.org
Subject: Re: [PATCH] dt-bindings: i3c: Convert snps,dw-i3c-master to DT schema
Date:   Tue,  3 May 2022 23:37:43 +0200
Message-Id: <165161385391.974772.7995938945274050743.b4-ty@bootlin.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220422192236.2594577-1-robh@kernel.org>
References: <20220422192236.2594577-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexandre Belloni <alexandre.belloni@bootlin.com>

On Fri, 22 Apr 2022 14:22:36 -0500, Rob Herring wrote:
> Convert the Synopsys Designware I3C master to DT schema format.
> 
> 

Applied, thanks!

[1/1] dt-bindings: i3c: Convert snps,dw-i3c-master to DT schema
      commit: 6742ca620bd929ee96bd6724692132056203fb95

Best regards,
-- 
Alexandre Belloni <alexandre.belloni@bootlin.com>
