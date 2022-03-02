Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6B7E4CAF3C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 20:57:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242772AbiCBT5n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 14:57:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242744AbiCBT5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 14:57:40 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1FCEDA850;
        Wed,  2 Mar 2022 11:56:42 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id i8so4485550wrr.8;
        Wed, 02 Mar 2022 11:56:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=NbmKVhEtPhGrxqVQA+EuZwuF4NJvA1JcTyRn1dRD68g=;
        b=JUBJHYsFw231gHvFxRX5h9vuDM7kcPA0aoSHKOB0Jx6iOK2Kgj3Pr5/pXm86LkJlps
         utqIRdAiq6uuLuFfCADAqKjXYjkZu1NMi1vHmdXX+F9VlcDYwzBbLX6PvgbEw8voRQuC
         cL859Rf4UWB0q4CY6DGtUofMHtsRb/mTPBF4Khq5O8uN/8ocHZOf8pHU34lAKco83VIu
         Hkay6RglaVyiYHlgnEpQT1Y4mAf0gclkSlaxxd9zK1k8euIsyj4P3iFEqBW4KEvZ59im
         Av9nwLCzNsUhg25n6MAqxg+QFGwJ78coDwy7FMXY2tm5V6usIawZlCkj5ciewBmos07J
         zd5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=NbmKVhEtPhGrxqVQA+EuZwuF4NJvA1JcTyRn1dRD68g=;
        b=tXWIO35uCdWuvvui5aQ6P4XMn4OJ2As0WbI/ELV5yaBXIKT8q55pYLhOUiWSur2Nxu
         yEj26LfRJVdTizXJ5Wj5zZ3PZlBlqVQc9aDUibSrStdncetOrGI0yc/OKe6Yyg8lcaYz
         2EKoI+FB/WWiNmV8xfKXjCeklRruYllYm2Yv/kavR0mvvllODOlXgjaIUo/fjcYbSaLH
         Xe46m4CPm+GJuLNg3BQQu5AcmXPKkVaOFM9+7hrbnpNLTmeXy+716QWUd0E4HmUxCkaT
         Ijwll20/lc5kA4uHdDl9eNcJnzkV2THYSSJqJOVCXhHhxdV2BFP3EdkRS/qrzGqOpIcV
         BtNA==
X-Gm-Message-State: AOAM532jIZ3czADg5KIvLg0LIxty8OS/35aVP6/IzwBCRMYE/1SlHD/K
        VJRXYI4PjmDtVWq8t5iK/5U=
X-Google-Smtp-Source: ABdhPJxt+gjYgCD5VpM8N/Snk43QbbhlCfEKawBGmlIzObus6knMb+mXHmVss6IEXKInyVN9TVSz0g==
X-Received: by 2002:a05:6000:2ce:b0:1f0:481c:6f13 with SMTP id o14-20020a05600002ce00b001f0481c6f13mr1832965wry.354.1646251001272;
        Wed, 02 Mar 2022 11:56:41 -0800 (PST)
Received: from ?IPv6:2001:a61:2a40:5b01:34db:b959:7b84:68a? ([2001:a61:2a40:5b01:34db:b959:7b84:68a])
        by smtp.gmail.com with ESMTPSA id m34-20020a05600c3b2200b00380e3225af9sm2031wms.0.2022.03.02.11.56.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 11:56:40 -0800 (PST)
Message-ID: <f22f0f902079e10bbc065733de7c41f7dc164f98.camel@gmail.com>
Subject: Re: [PATCH v3 1/3] iio: temperature: ltc2983: Don't hard code
 defined constants in messages
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Date:   Wed, 02 Mar 2022 20:56:40 +0100
In-Reply-To: <Yh+SQgD0Bq5qq6Cm@smile.fi.intel.com>
References: <20220210135522.26562-1-andriy.shevchenko@linux.intel.com>
         <20220213175559.46e8dee2@jic23-huawei>
         <Yh+SQgD0Bq5qq6Cm@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.3 (3.42.3-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-03-02 at 17:50 +0200, Andy Shevchenko wrote:
> On Sun, Feb 13, 2022 at 05:55:59PM +0000, Jonathan Cameron wrote:
> > On Thu, 10 Feb 2022 15:55:20 +0200
> > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > 
> > > In a couple of messages the constants, which have their
> > > definitions,
> > > are hard coded into the message text. Unhardcode them.
> > > 
> > > While at it, add a trailing \n where it's currently missing.
> > > 
> > > Signed-off-by: Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com>
> > > Reviewed-by: Nuno Sá <nuno.sa@analog.com>
> > 
> > Mostly so I can remember what is going on with this patch,
> > Nuno is OoO and planning to test this series when he returns.
> > 
> > Given that I'll wait on Nuno's testing.
> 
> Any news?
> 
Started to prepare things by the end of the day. Should be tested by
tomorrow.

- Nuno Sá

