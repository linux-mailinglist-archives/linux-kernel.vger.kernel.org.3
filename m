Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9337E5612FD
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 09:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232707AbiF3HNL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 03:13:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232006AbiF3HNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 03:13:08 -0400
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [IPv6:2a0b:5c81:1c1::37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC3B3C32;
        Thu, 30 Jun 2022 00:13:06 -0700 (PDT)
Received: from hillosipuli.retiisi.eu (dkwl20tj04snw15cjtflt-3.rev.dnainternet.fi [IPv6:2001:14ba:4493:6f40:fec3:d72a:e447:8113])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sailus)
        by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 2190F1B0011F;
        Thu, 30 Jun 2022 10:13:01 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1656573181;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V1GwN0phV9CjwytxwcYqLBT2uIOvBqBalT04SfuO9pw=;
        b=Gthv/RBugMz0hoKp2zMArTAEwk55ve2VoWRwSJijYDKS7hkdXHXFCUqcY+kyilCiA6m1Rz
        iQG742j+7Qsuzcty4uPmq7EneOAsj+H1+5cKQGVIxAlfy7vjdEU7gA9aWf63frO0FPLDTf
        3DTOODnFj0lW0W86cWXU2+PVSx6WQG5WmLGdbXmEl46oaMWyuydMkKg/lKVKl0gCf8NjVz
        7Wz2b+ZAzBUBG1t7EBhHh68LQIfc14qPsVe4bCFAtG/yvHj0NivFsCfo4yQe1ztf2pgU63
        4HXMMCId/iSGdFmgYMFHN2CHnw+feEtDwoT/ITAcV//2rXEn23a8Hic3N8YWdg==
Received: from valkosipuli.retiisi.eu (valkosipuli.localdomain [192.168.4.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by hillosipuli.retiisi.eu (Postfix) with ESMTPS id AA1A0634C92;
        Thu, 30 Jun 2022 10:13:00 +0300 (EEST)
Date:   Thu, 30 Jun 2022 10:13:00 +0300
From:   Sakari Ailus <sakari.ailus@iki.fi>
To:     Krzysztof =?utf-8?Q?Ha=C5=82asa?= <khalasa@piap.pl>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Joe Perches <joe@perches.com>
Subject: Re: [PATCH v8 2/2] On Semi AR0521 sensor driver
Message-ID: <Yr1M/EKiB3O3QwKJ@valkosipuli.retiisi.eu>
References: <m3pmn66pie.fsf@t19.piap.pl>
 <m3h78i6p4t.fsf@t19.piap.pl>
 <20220301093107.ihokyp4xptkzpbpc@uno.localdomain>
 <m38rtt7sx7.fsf@t19.piap.pl>
 <20220301143044.2l4vlwbnh5n3g5ng@uno.localdomain>
 <m37d7ufrzx.fsf@t19.piap.pl>
 <m3pmkryywn.fsf@t19.piap.pl>
 <YrziTabYLlZ2bX+1@valkosipuli.retiisi.eu>
 <m34k027p0t.fsf@t19.piap.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <m34k027p0t.fsf@t19.piap.pl>
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1656573181; a=rsa-sha256;
        cv=none;
        b=iNiVeHwqQQCk57kl0NoRN7AguPz2HMb/sFxpOcl4beY4fUoi9OcESZ6qqcPfvpRAqtZHJ0
        XrY9m2BVlddYYnggQOwWQ88Z2EqUYAHDAaoAqdXKvSRgBBoW8Q55+ubixGp2jth5UX3gkN
        0m65w+4fBK0K5igDTgp85oTNJPEqG4TyOw9LsfNY3mKSPcDTpdmWkF8K2K9lO/OddGaVBf
        zz+DsxX6rhAgbIr3Ijo7MwV7gefyU2mei6OqDdzREP4+UM7KuWwoloiVEOwenVsKCThmgK
        aTj1N4gB8++3+SFfyhh0jaGIs5Ourn2wCZgC/IpHh/5X1MSpmWoNLKIov2QvOg==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=sailus smtp.mailfrom=sakari.ailus@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=lahtoruutu; t=1656573181;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V1GwN0phV9CjwytxwcYqLBT2uIOvBqBalT04SfuO9pw=;
        b=JO0K2X5dwYwNpWk6APkpLLdieikNGykTZsqK41tRLOiduIIpi5t5h/IvkYpy5XbjjR4DHO
        rQAkX/1zPmqSEYOsF4pT3Be2xJrk+8Egq77tRpQcFQrGsREgjjHVkxk5oHk97j+fpjxt+J
        +qElXiXSuraUMQ2MM45K38dVjcrkJy+WNjWbwQ1d3szGiWo24BAgzb1ARk3nguqjXrlIXE
        B+3AufbJzusn/5LV6iCOTKdVlOKCVq5jJBQrUPo0+XW4TXpekUdqOSMsZA9gWEduXH36UU
        t05XeVWkE86wsbXTroceYLc2YhexrkOcyBrFj6P0hzzWHM0F/9/xsxuDEJ0AOQ==
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 30, 2022 at 06:29:06AM +0200, Krzysztof Hałasa wrote:
> Hi Sakari,
> 
> Sakari Ailus <sakari.ailus@iki.fi> writes:
> 
> > I've
> > applied it with these changes:
> >
> > diff --git a/drivers/media/i2c/ar0521.c b/drivers/media/i2c/ar0521.c
> ...
> > @@ -1056,4 +1058,4 @@ module_i2c_driver(ar0521_i2c_driver);
> >  
> >  MODULE_DESCRIPTION("AR0521 MIPI Camera subdev driver");
> >  MODULE_AUTHOR("Krzysztof Hałasa <khalasa@piap.pl>");
> > -MODULE_LICENSE("GPL v2");
> > +MODULE_LICENSE("GPL");
> 
> Why did you change this? Are now "GPL v2" tags forbidden in
> drivers/media?

It merely exists for compatibility reasons.

-- 
Sakari Ailus
