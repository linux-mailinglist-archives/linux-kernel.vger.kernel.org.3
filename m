Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 145B34D3CCC
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 23:21:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238579AbiCIWV2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 17:21:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233383AbiCIWV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 17:21:26 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1224119841
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 14:20:26 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id m22so3607997pja.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 14:20:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1Q5BPjuJiQt+EM+EYWq+KhpZ4M3rBZRhIyyMRcgGVCA=;
        b=WmcE7BQ8GQJ5ycr8TxP9O6PpFKCDOu9t6cdPzRIV23d6dcCXXvn5unHOJESOJOjerE
         Bo+02smgT8g/lnjvxq8GMIt6D1hXzFePByfhmTUyTEwM3iuLbikUjGHvl6sP7XDb83tS
         5M/S/H0ipO3LU+nGzI2XK1SmGastSY3qiu1nc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1Q5BPjuJiQt+EM+EYWq+KhpZ4M3rBZRhIyyMRcgGVCA=;
        b=U0DnQ8LsKASytTod6PxX1Udxn2qIi6K6BwmwWLUuhVqtO1RcaC+NWkFjp5JONRW7hw
         nxwINMdkEVwS7i1PmWTi5M8S3cZRQOjSqvT7Fb+5CCMAtvFxlOLMmJ0dVgjv7NdwOlg0
         W0MIUPmgowd2T+gUFJLJD7BbnsyEapKq4cJXTIq08FVQE/3SGOt32KlFW9l7v0n4Kta9
         9Zi5kq/6OnzzAVukfXxTU6dyVL6DBHwCWhdSqQDpGdLxpRwnlrF5l6skQ5BVw2LZNHCW
         ULm6ObkAQDv3zgfC1yRn26Eg/zdENhLoSWdF1IkQ8NlycuqEjRFs11uLIxsHQ08woIfI
         z2yw==
X-Gm-Message-State: AOAM5339jn9D/PIrQNGdzBCiAX7GrTh19HBj8J1/DGYcUK25gJVO814Y
        EJyyhoIRFTmwOA0jJudM0HWegg==
X-Google-Smtp-Source: ABdhPJyC6BHTDxUs1ieOhb/w8RyXvV+PPSefuy7EYj4oz5fHzwqAWcFXmhgfPZ/lSJYtTGthp51EHg==
X-Received: by 2002:a17:902:6a86:b0:151:f1c5:2fa3 with SMTP id n6-20020a1709026a8600b00151f1c52fa3mr1680461plk.77.1646864426519;
        Wed, 09 Mar 2022 14:20:26 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j9-20020a056a00234900b004f6fe0f4cb2sm4286499pfj.14.2022.03.09.14.20.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 14:20:26 -0800 (PST)
Date:   Wed, 9 Mar 2022 14:20:25 -0800
From:   Kees Cook <keescook@chromium.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexey Gladkov <legion@kernel.org>,
        Kyle Huey <me@kylehuey.com>, Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 02/13] ptrace/arm: Rename tracehook_report_syscall
 report_syscall
Message-ID: <202203091420.72F5701C0D@keescook>
References: <87o82gdlu9.fsf_-_@email.froward.int.ebiederm.org>
 <20220309162454.123006-2-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220309162454.123006-2-ebiederm@xmission.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 09, 2022 at 10:24:43AM -0600, Eric W. Biederman wrote:
> Make the arm and arm64 code more concise and less confusing by
> renaming the architecture specific tracehook_report_syscall to
> report_syscall.
> 
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

As a person who is repeatedly stumped trying to finding this function,
yes please.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
