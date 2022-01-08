Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8A1D488004
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 01:48:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232054AbiAHAsM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 19:48:12 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:34310 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiAHAsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 19:48:11 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DCF1F62044;
        Sat,  8 Jan 2022 00:48:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DC10C36AEB;
        Sat,  8 Jan 2022 00:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641602890;
        bh=IM6DZCckcai0O2zZ0JKkNbO8kDDl9nphrbzpRK7mZkU=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=hRgf0+44YcCLZH6OJyklfqSBa7ERMz5knw7OMaZ6EPRhUU4JQ9HJX8CiucqRqRc3Q
         TVzngM+/OeudjjWI9mvdt55lJg1r6yN4NYrqa3NFhhxZejXlACsLkoen9sPYXgLsnz
         qe9SmcNVyOqZZuStRqsAWJb6PCFUGHoQ/4z40IQqoU1LIno7j/vFXscerQmA4RFUYj
         FMn65FzRj/ZgOMouSodkatRVBI3cmFRQEi0bbsBU6etrL3SqxMzLd6irBmF6X7mjn8
         bfBMqYTOuv0assn9wGzU+VArUSegZuRVPxX7EEpJQpMboH21s+2C8+VI1l7PsaEdF/
         jg77iz+xTorXQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20211216141338.35144-5-claudiu.beznea@microchip.com>
References: <20211216141338.35144-1-claudiu.beznea@microchip.com> <20211216141338.35144-5-claudiu.beznea@microchip.com>
Subject: Re: [PATCH 4/8] ARM: at91: PM: add cpu idle support for sama7g5
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        alexandre.belloni@bootlin.com, linux@armlinux.org.uk,
        ludovic.desroches@microchip.com, mturquette@baylibre.com,
        nicolas.ferre@microchip.com, robh+dt@kernel.org
Date:   Fri, 07 Jan 2022 16:48:08 -0800
User-Agent: alot/0.9.1
Message-Id: <20220108004810.3DC10C36AEB@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Claudiu Beznea (2021-12-16 06:13:34)
> Add CPU idle support for SAMA7G5. Support will make use of PMC_CPU_RATIO
> register to divide the CPU clock by 16 before switching it to idle and
> use automatic self-refresh option of DDR controller.
>=20
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>
