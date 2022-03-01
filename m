Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E930A4C8CCD
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 14:39:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235097AbiCANjy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 08:39:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbiCANjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 08:39:52 -0500
Received: from meesny.iki.fi (meesny.iki.fi [IPv6:2001:67c:2b0:1c1::201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DD7232052;
        Tue,  1 Mar 2022 05:39:11 -0800 (PST)
Received: from hillosipuli.retiisi.eu (dkvn5pty0gzs3nltj987t-3.rev.dnainternet.fi [IPv6:2001:14ba:4457:9640:1e2d:1f75:a607:ef37])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sailus)
        by meesny.iki.fi (Postfix) with ESMTPSA id 6566A20039;
        Tue,  1 Mar 2022 15:39:09 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
        t=1646141949;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PD/Gt8AEGoZfPCQ5uXtPnMbIOq13hkJVTYqaYQvMPtk=;
        b=MIJkKbG4hMUGK5ygQW8/zJEL6jGZsp3QXXLGZ9ceZS4g4HC2jDwSmAuelQL92APxa69QQt
        KS0uZZTwe+VlBTKjmQD4FWd0Q1UGzlbPOuKIvTuvcno5/GeLbfxAR7QUZcZO0zWNqV+k4k
        hHUW6Cb2Cf3fOrU1Tse/xtqOpM5CPQk=
Received: from valkosipuli.retiisi.eu (valkosipuli.localdomain [192.168.4.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by hillosipuli.retiisi.eu (Postfix) with ESMTPS id 818F5634C90;
        Tue,  1 Mar 2022 15:39:08 +0200 (EET)
Date:   Tue, 1 Mar 2022 15:39:08 +0200
From:   Sakari Ailus <sakari.ailus@iki.fi>
To:     Jacopo Mondi <jacopo@jmondi.org>
Cc:     Krzysztof =?utf-8?Q?Ha=C5=82asa?= <khalasa@piap.pl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Joe Perches <joe@perches.com>
Subject: Re: [PATCH v8 2/2] On Semi AR0521 sensor driver
Message-ID: <Yh4h/HThZbXltN6G@valkosipuli.retiisi.eu>
References: <m3pmn66pie.fsf@t19.piap.pl>
 <m3h78i6p4t.fsf@t19.piap.pl>
 <20220301093107.ihokyp4xptkzpbpc@uno.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220301093107.ihokyp4xptkzpbpc@uno.localdomain>
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=sailus smtp.mailfrom=sakari.ailus@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1646141949; a=rsa-sha256; cv=none;
        b=WXdIwXkcF1sHLC3WY8URND6uEBkLkGRkOlNBSyw32YN3cLGOxECjwD6zanC6KDy80YiWbP
        cnZVeOds/ttOsEa51ZLCcg7Ci5dqP/HejKq9/36n9JofOjvcNzuWT+toZHGwiiHN3dqBSz
        w4qmzmUR4MqL16FriKdy1flngDkwf6Q=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=meesny; t=1646141949;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PD/Gt8AEGoZfPCQ5uXtPnMbIOq13hkJVTYqaYQvMPtk=;
        b=P+2EWL2hEZiZZDi5S9kvRa+fb4o1H7O8v2R1bPzT21doYa/TZ6h2ec3uUz4dNhXVz+7gyo
        K6LGT9gh9Io7AsjMlfBk7dXimiAOd+P2PRFilvoSRKXodlVtv72zjpVj+UrKtJy0NOvIrb
        eRg7dzrpZTyU3T8GflsRMbofjAqXbrw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacopo,

On Tue, Mar 01, 2022 at 10:31:07AM +0100, Jacopo Mondi wrote:
> Hi Krzysztof
> 
> In subject
> 
> "media: i2c:"
> 
> Same for 1/2 where permutation of "media: dt-bindings: i2c:" are used
> when adding bindings for media i2c drivers.

Some i2c driver patches tend to have these, some don't. "media" is added by
Mauro's scripts in any case.

-- 
Kind regards,

Sakari Ailus
