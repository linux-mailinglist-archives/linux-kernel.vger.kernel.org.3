Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 424EF485D3A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 01:34:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343856AbiAFAeX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 19:34:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343830AbiAFAeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 19:34:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70380C061245;
        Wed,  5 Jan 2022 16:34:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 10D216193C;
        Thu,  6 Jan 2022 00:34:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66E81C36AE9;
        Thu,  6 Jan 2022 00:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641429251;
        bh=jMICUvfWqDl6yU+e1z03F+e1bc2tGxcy1cr8nmpYT9s=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=V7sw9/ItzULOjdm7rsvyOr+0aqNy0gBiS2gW2BvNiAbEwpXBTUJc5gFgRVeLTdYfF
         GaTJ/J1S4cagCkxUS8Y8X6UWWLZ+td6NUyTHHbdhyB3E11GsFQjpHpe61kW8ji+3iY
         eFVqSFfIOkR1VgrnE8jfx9/sRR3CgZepKrTj03RxgslpyLGzHYeWz7IurSx2h4Pr0e
         7G7g8aeFqqRuoXhGTaNflOkBjoUCs36DB2z0Dg4675TGIW7KvUnCvOd166zAnpeRB7
         UZbaJnqWRp9nGAmyjf2zQAgLjNBgejNCci4qCj3LM/YbLc63ojF7ahB2bS4cyBAS8T
         WEQvDRANotLKA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20211227133558.135185-2-krzysztof.kozlowski@canonical.com>
References: <20211227133131.134369-1-krzysztof.kozlowski@canonical.com> <20211227133558.135185-2-krzysztof.kozlowski@canonical.com>
Subject: Re: [PATCH 08/19] dt-bindings: clock: intel,stratix10: convert to dtschema
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Dinh Nguyen <dinguyen@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Date:   Wed, 05 Jan 2022 16:34:10 -0800
User-Agent: alot/0.9.1
Message-Id: <20220106003411.66E81C36AE9@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Krzysztof Kozlowski (2021-12-27 05:35:47)
> Convert the Intel Stratix 10 clock controller bindings to DT schema forma=
t.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>
