Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A617C570494
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 15:44:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbiGKNoK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 09:44:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230399AbiGKNnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 09:43:55 -0400
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [IPv6:2a0b:5c81:1c1::37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5914116F;
        Mon, 11 Jul 2022 06:43:50 -0700 (PDT)
Received: from hillosipuli.retiisi.eu (89-27-103-169.bb.dnainternet.fi [89.27.103.169])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sailus)
        by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 6B14E1B000E0;
        Mon, 11 Jul 2022 16:43:47 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1657547027;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EluWmIIUJxvr7SA4wTQouzBF9nmaOCP6Dx5/r969wak=;
        b=jMPZZKxAGCUYgmypae0r1zi5xD/0LFMxc+8F16hdZVR6eaOava31hZjQG+oDh+ll52lm5q
        LsOJguT6DuSvtPtyfOvQuMIPOy6CDg77pEX84Yan7N70TjgJyVMzXEe/NNbtKaE8h5tUCb
        uRN1QarbLJCOjG8yoFx4WJ7L9p5zYvT09oyIlyXfyMxbt183Ap4gk0937wYcQUDMRM6gh3
        OLjVqIHDAZxr0Oe2PAy3yyf0FP65+tjIvpJaFd3S+pJQTtYARRfiK5Y+JGKJXSUfiF1OiR
        x3EIQ1euD+6554xrUMpbyf7Z/341FfniEdv4cvxNmyQZEmBg1fTr2qrQ3dxYgQ==
Received: from valkosipuli.retiisi.eu (valkosipuli.localdomain [192.168.4.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by hillosipuli.retiisi.eu (Postfix) with ESMTPS id EDB27634D5F;
        Mon, 11 Jul 2022 16:43:46 +0300 (EEST)
Date:   Mon, 11 Jul 2022 16:43:46 +0300
From:   Sakari Ailus <sakari.ailus@iki.fi>
To:     Deming Wang <wangdeming@inspur.com>
Cc:     mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ovl: Modify the section of Return Value
Message-ID: <YswpEo+liqx9qBCI@valkosipuli.retiisi.eu>
References: <20220624014707.2057-1-wangdeming@inspur.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220624014707.2057-1-wangdeming@inspur.com>
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1657547027; a=rsa-sha256;
        cv=none;
        b=lBcoLn+UOrbixn8DIme3yR1+2yKbRZvldDuErCa+3rabvt8/tO+swQzWq4b5QXkNaV0kAi
        Z1YVbhr3TRrvI4ekYhpBF09V/MQcApZfej5lqsdgS1RG8X2wQN9Orl8bMIc/HGjLTYoMtM
        QM+5+8C0SRJGq76rvSZya1japm0bHtFDFItnyrvO57cPu27G9tKckkBTYK+CGWhhmwr4bB
        zQ0VxFw6xYW33xMJQsIJS769QycQ4fe+XjmgE6v4AWrG7X4XqZFHpfGJFpgtRHIpn3QTiz
        aSFSycgHBeXHOnHxRcIsYjmB04YLGUneW0la65fhzoTp05BOgY9yLefJFkuHng==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=sailus smtp.mailfrom=sakari.ailus@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=lahtoruutu; t=1657547027;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EluWmIIUJxvr7SA4wTQouzBF9nmaOCP6Dx5/r969wak=;
        b=ntgK91V9HqVo8mWXPNy0PIStFxYgfEY37WnRFVdI/mrxuxiO0FFd3PZ/eFcynKcCNZmaj1
        UbrlSsNwLKLKSdASBjLG4E0Y3NS77mF/QZXOFvhhV2QGSkNXQn83xtjNUN3Ml5jqSf89G2
        sdiYp4Z03Me43tf0cYbj6/euG0hZ5HFn3Uukl3FEF/eFqVgmT7FIpNidomj7ir2S6J+tn7
        ABllOLjZN02NGI+Ry9UM7PWNGoaAAGnSw0bhYEx+aTAVTdweaqKzgZmO+Jz9HHnknSuu4D
        VccT0feLIByl1T0kgHALmYquArXMpVFpnIwjvI6e4HBhdEvLo6D3HFuUsFMfpg==
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Deming,

On Thu, Jun 23, 2022 at 09:47:07PM -0400, Deming Wang wrote:
> Delete duplicate words of "the".

Thanks for the patch.

The patch itself seems fine, but I'd reword the subject and try to improve
the commit message.

In the commit message, there's a single article (the) and "of" is just
extra.

-- 
Regards,

Sakari Ailus
