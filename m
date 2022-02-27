Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3BB64C5DFA
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 19:11:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbiB0SMG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 13:12:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiB0SME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 13:12:04 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F02835AA66;
        Sun, 27 Feb 2022 10:11:27 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id h15so14491640edv.7;
        Sun, 27 Feb 2022 10:11:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=z+phHXBhP7sUmpqoJ5E/GXm8zjzTONi6SCknpLMTWwk=;
        b=mCna3VHZDBV/ehGjjh9gJuiZ3d6mSnMU2mTQiVRUzLnpUZXSrvNDm3RgzYDVLRv06S
         it9lTLQNhOBn0INuUc5ymovisl4lZfXFmTAx0ra/VvBuH/6uPfcoUkE8CO/2puVYSuHv
         zu4+ApFs3TbrRcSuwUzt8MvAvfkcM9kso09rJ3ln/rQtpXANZTTfbSXSWOkRVglOyPeY
         mSi83bei30FD+a6oRcb1Sq7a91dqsF0edmCvcIdJPA0/2KZKcRG1/iAWQxLhLwUd/lNS
         RCkp62emiSkTIGlHNnu4D97ST1q3ADKg5VpwKpAct8Ota64KDztJ5iUce2oIsOtjUmmE
         AsXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=z+phHXBhP7sUmpqoJ5E/GXm8zjzTONi6SCknpLMTWwk=;
        b=ZSW4sjG9cxjeThQ+e9fVvlZKjBAsQBDRJTf+lvLDYU0jJSFDKUjM4MkB7d6bEZC+Ip
         RnVpm69Atjxxe2pVDwJy4OQOqsX6Gnl/lEiCnHPJuGOVxyqtkzSSXOhgeVjUZbszkUBa
         7VlJg0D7yT1SLp92+7H0LOh+aup9O4+JmIW+EBAUG0kZpYqBF+2ZEKcIl0gQJuIBua08
         WFLdCtFi2w/x2xWUNlXqW+XUOCLUEjfjExIcsj2utzh+hh/cCn/B6E5UBIS5kQRgPlYb
         00xvul8eBGRyvmloyfe+L8KqiqRBptsO/vhkg7qhiFKikfATF8JJj00QJ4SGFkXchldu
         GgwA==
X-Gm-Message-State: AOAM533sUC0ANZkmFbheA3SwaUJ0T2ZIjg2fnrE52Z6VrYCXYAdyYc9D
        9/zkG7Aj0DMl5UJ+qMIQAZhi7EsxWcocAyJp
X-Google-Smtp-Source: ABdhPJwkoKI9LGdfq+SBKpPijHSVg3658GE2tCtyAPH5wnbfF0ml4bQtTLWyBhjQAjIWnbB9pKVKFA==
X-Received: by 2002:aa7:d694:0:b0:410:d89a:656e with SMTP id d20-20020aa7d694000000b00410d89a656emr16664734edr.402.1645985486517;
        Sun, 27 Feb 2022 10:11:26 -0800 (PST)
Received: from fedora ([95.180.24.23])
        by smtp.gmail.com with ESMTPSA id by10-20020a0564021b0a00b00412ddfc6d12sm5068591edb.0.2022.02.27.10.11.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Feb 2022 10:11:26 -0800 (PST)
Date:   Sun, 27 Feb 2022 19:11:23 +0100
From:   Aleksa Savic <savicaleksa83@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-hwmon@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] hwmon: add driver for Aquacomputer Farbwerk 360
Message-ID: <Yhu+ywPYqkzMQUZv@fedora>
References: <20220227105926.64862-1-savicaleksa83@gmail.com>
 <a54a19e1-703c-5cdf-0a13-ff3f4cbd81a2@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a54a19e1-703c-5cdf-0a13-ff3f4cbd81a2@roeck-us.net>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks. I'll send a v3.

Aleksa
