Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8D144C64EA
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 09:38:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234046AbiB1Iiw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 03:38:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231856AbiB1Iiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 03:38:50 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD7E61401E;
        Mon, 28 Feb 2022 00:38:12 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id p9so23196619ejd.6;
        Mon, 28 Feb 2022 00:38:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JQm0tlsam6bm+m6NkO8osPqj5frrgEizwleEw0BE+6I=;
        b=hJvGQln7bh9326jk67+hT7mJBgmr3JpEMrx3g7eGB+6QqZhlqkwcRYMbT+nGWXBPUj
         D01tOmT4cVzzZ3ygjS5Idwjj3vU/LDP37IOeMis3gXDTRQOSZyaT95RVE/3S3Q9t+TwT
         4M2QKS/gJ81rm+1xiUwiZlsWpWe2mcrk7hauBVfu9IOt8cwZ6Zma6XJfcb9Ao3JQoQKu
         zPefLV+Bv2fR/ui0TcY8PDrs5ZKYnsOGNsPfonkiafGaQH5/oohOWYpUg+Km1OIETjJT
         LMk4yNzD+5xvwFQ1Y5PXUx7obthXJpQmcmHPF8ne7gGgph/rxC7jbIp0Bj0TzCj4moMO
         o2QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JQm0tlsam6bm+m6NkO8osPqj5frrgEizwleEw0BE+6I=;
        b=KfY+dEp6xKGGteoh5ngQU619ReeBDwVx/KZDYB8pHwArioslH2dTfSnTdZnU74K6hn
         D8bFSQ9FIGf9+ONmA4adt3ugRouKs03re1gW9PRx/92jlmADBg+qQz7k4KWKRlO0u3AX
         dHY1srxmz9acOVQvRk13ryw3zF/oDrWZY+LaymdrFyhYLlMMin0bURRMRxIufRkmYCwL
         x8nZpJXVR60CFo+9gRtcIZbYtkAmhIp24sOYTuNYfn5kLeb9QemQFtw4Yijwm9bjeCGQ
         ZAFDtpaaC3YOlAWJL2gG4WmbicsLiUdqouPo5nGgx9nuAvaENdnK8qnumEFMsfBuYe+7
         /UCA==
X-Gm-Message-State: AOAM5328tsPgTTGc0QculK0/++2yuzQGJ8FUFf9Wfwq1oQDqgP5NqNpr
        ixyFxxf2SgpFm10ZslMmPoClpMkdBu9orxg9
X-Google-Smtp-Source: ABdhPJz8gPVvl7f5HAN4QOcl+qy5YQZJWDuw/pJcAR1YkK2ontVlkQ+eof5T88SnAPq+ByRNm/8Pbg==
X-Received: by 2002:a17:906:3e90:b0:6b6:829b:577c with SMTP id a16-20020a1709063e9000b006b6829b577cmr14908062ejj.711.1646037491294;
        Mon, 28 Feb 2022 00:38:11 -0800 (PST)
Received: from fedora ([95.180.24.23])
        by smtp.gmail.com with ESMTPSA id n24-20020a509358000000b00410bedd9eb4sm5866886eda.88.2022.02.28.00.38.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 00:38:10 -0800 (PST)
Date:   Mon, 28 Feb 2022 09:38:08 +0100
From:   Aleksa Savic <savicaleksa83@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-hwmon@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] hwmon: (aquacomputer_d5next) Add support for
 Aquacomputer Farbwerk 360
Message-ID: <YhyJ8OY+7fjoK/mK@fedora>
References: <20220228010358.GA169239@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220228010358.GA169239@roeck-us.net>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you, much appreciated! Sorry about the mangled patch earlier.

Aleksa
