Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EAE74C6406
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 08:49:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233718AbiB1Htg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 02:49:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231867AbiB1Htd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 02:49:33 -0500
Received: from ni.piap.pl (ni.piap.pl [195.187.100.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8576F3D1CE;
        Sun, 27 Feb 2022 23:48:52 -0800 (PST)
Received: from t19.piap.pl (OSB1819.piap.pl [10.0.9.19])
        by ni.piap.pl (Postfix) with ESMTPSA id 4A7C4C3F2A54;
        Mon, 28 Feb 2022 08:48:48 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 ni.piap.pl 4A7C4C3F2A54
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=piap.pl; s=mail;
        t=1646034528; bh=KWt1aJphAP4xMpPdLN9k3CBn6uEAPCiswJSyjzSZ9+o=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=AImQVRQN7yUvuGLtiShcFQTbgXXTwezMYl6SygPRxytbaeq81d37XjrOpepRcYXrQ
         tFhNVjx2uVhCo9Y/JFB2vz5NqizfB8bsffWuxWnRsbRzTIBKWoExuX0G+eKL0oOYBl
         tk85IDF/FB+WvBUglsObjzdSRBFcwLV7NI7DgkZU=
From:   =?utf-8?Q?Krzysztof_Ha=C5=82asa?= <khalasa@piap.pl>
To:     Sakari Ailus <sakari.ailus@iki.fi>
Cc:     Jacopo Mondi <jacopo@jmondi.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Joe Perches <joe@perches.com>
Subject: Re: [PATCH v7 2/2] Driver for ON Semi AR0521 camera sensor
References: <m3czl9eylt.fsf@t19.piap.pl> <m34k6leyb1.fsf@t19.piap.pl>
        <20220109153439.bfnfigocaeeeghmp@uno.localdomain>
        <m35yp387n4.fsf@t19.piap.pl> <YhjXEvtPlOv/jH4n@valkosipuli.retiisi.eu>
Sender: khalasa@piap.pl
Date:   Mon, 28 Feb 2022 08:48:48 +0100
In-Reply-To: <YhjXEvtPlOv/jH4n@valkosipuli.retiisi.eu> (Sakari Ailus's message
        of "Fri, 25 Feb 2022 15:18:10 +0200")
Message-ID: <m31qzn8m8v.fsf@t19.piap.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-KLMS-Rule-ID: 3
X-KLMS-Message-Action: skipped
X-KLMS-AntiSpam-Status: not scanned, whitelist
X-KLMS-AntiPhishing: not scanned, whitelist
X-KLMS-AntiVirus: Kaspersky Security for Linux Mail Server, version 8.0.3.30, not scanned, whitelist
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sakari,

Sakari Ailus <sakari.ailus@iki.fi> writes:

>> >> +	// access the sensor only if it's powered up
>
> /* This is the preferred comment style */

I keep forgetting about this. Maybe because most other code I work with
(not drivers/media) has already switched to // (single-line) comments.

> The OF folks have shunned to the use of the iterative varants as that can
> often lead to complicated parsing of the endpoints. As obtaining the
> endpoint based on port and endpoint IDs works well in all cases I've
> suggested people to use that. But as the backend, at least currently, uses
> iterative functions, they're unlikely to disappear in the future.

I understand I should continue using fwnode_graph_get_endpoint_by_id(),
right?

Thanks.
--=20
Krzysztof "Chris" Ha=C5=82asa

Sie=C4=87 Badawcza =C5=81ukasiewicz
Przemys=C5=82owy Instytut Automatyki i Pomiar=C3=B3w PIAP
Al. Jerozolimskie 202, 02-486 Warszawa
