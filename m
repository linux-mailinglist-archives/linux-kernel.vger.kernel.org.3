Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 872D4481F12
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 19:11:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241632AbhL3SLa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 13:11:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237218AbhL3SL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 13:11:29 -0500
Received: from polaris.svanheule.net (polaris.svanheule.net [IPv6:2a00:c98:2060:a004:1::200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 765C3C061574
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 10:11:29 -0800 (PST)
Received: from [IPv6:2a02:a03f:eafe:c901:a9e6:6f2a:78f1:2f3] (unknown [IPv6:2a02:a03f:eafe:c901:a9e6:6f2a:78f1:2f3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sander@svanheule.net)
        by polaris.svanheule.net (Postfix) with ESMTPSA id EF56C28A0EF;
        Thu, 30 Dec 2021 19:11:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
        s=mail1707; t=1640887888;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1LlsOc0XKHSOXOCSgkqOLv7yx0nbdOQV6NO9Werr8Us=;
        b=Dt6EYNk+PTJoMPt5z+epeIbHLEwvNKsgFFgmTH057U0yJ3l5T4fDMggccJApkkEcK+BAUT
        x3W7fVY3jzeP24Kt3SeRIZprcSh38+m5uMWTc+hQG2Lr58Bk2D5Hhbr47uxc9/QwwXPl3/
        CkGn5orMIFDtMpl+OPI2/AUV28rRBVIjNf4cvlrXO/IQP1a60XawXhOLkRghtUXEtKbNzV
        i5H1UeEakLmyMCLnwCl6luXtRNnLX7JxRlkOPnRycBnRfTfx7PmMeZ9+WZ4a2fxQyA/M21
        xCRJyE7zAk07CPD+1A4a10gD4QnMlAGJX7T9gv8N8BXJDe3g2CMx+juzPRIYog==
Message-ID: <6c2b8578215a5a5354a544d558a1ac45ec1577da.camel@svanheule.net>
Subject: Re: [RFC PATCH v1 1/3] dt-bindings: power: reset: Convert
 gpio-restart binding to schema
From:   Sander Vanheule <sander@svanheule.net>
To:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org
Date:   Thu, 30 Dec 2021 19:11:26 +0100
In-Reply-To: <c47705dbf6e9e287332f3ccb91578e81dbb81625.1640887456.git.sander@svanheule.net>
References: <cover.1640887456.git.sander@svanheule.net>
         <c47705dbf6e9e287332f3ccb91578e81dbb81625.1640887456.git.sander@svanheule.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.2 (3.42.2-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2021-12-30 at 19:06 +0100, Sander Vanheule wrote:
> Convert the gpio-restart binding from plain text format to a schema
> binding, maintaining the original content and updating formatting where
> required.
> 
> Signed-off-by: Sander Vanheule <sander@svanheule.net>

I had these patches set aside since a few weeks already, but apparently this conversion
was merged last week. This patch can be disregarded, sorry for the noise.

Best,
Sander

