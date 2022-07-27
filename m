Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9DE7582064
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 08:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbiG0Gp7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 02:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230314AbiG0Gow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 02:44:52 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D35B241D1A
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 23:44:48 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id e132so15139769pgc.5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 23:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VNSbDBtqUL6BShJWKBGM9krLOSy1yEEczJDuS4MigCg=;
        b=6KEAwYjLNXnmDPwmdISfwjHInq3VkUx4AxWASmzbmzHZFxKbPWaNCtF+o6gbi6i3Xy
         kUMQuFr2aZQa4q3wMLVwt4SDX6IPwJc1gpNCBNl3IwvRiVT2ITZP4QcgZ7TUg7Oydpdm
         nE4DJOIumn3XPoph0BHgp8QwTTCKByTTAwV7pSzX/vqGzpyhALc+owERemaOh4rym1WK
         Cb75v/aJ8CZnbcKM0z1QR/+R1PMFMTzswcnO7fhqnFxBP4C2T/CgVVNXXROaiYMTEUSd
         db8i0mN7RLp1cH/5V5gbl9I5bIirrTPpU1AVy++vCIMtzWwdP04F0sNM/kB0ByHMI0/Y
         dGtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VNSbDBtqUL6BShJWKBGM9krLOSy1yEEczJDuS4MigCg=;
        b=uRzs1sJxJoHLZv/zearDyvGyzYq8mBtay/FnmF22FiU2mrePYb/aP+++72XNrONGaV
         R5B8yobytRqQ9R6Y2BesTnerQa3uxqWux1hg4I5OmWza/NVle78NTkqV7A6p7RPQYel/
         bdfWRsLBXoLsLeJ8djSsstVfVvjVeAGroQQywKyW+bhLFT0P4wldyICHxVCjNjObKasw
         FHWxTD2nrYnQByM+RWWobflwl+dg8LPQzUceHszSnWJ+AU5gcC6M/HCK3oe7AGNH/IFb
         1qemF0jsA8XLdhObdmvHN8A68xZ/7fOx1WAN5JDuSoS9LIj/Y/AivypGJ15cY0F4g5xE
         T6zA==
X-Gm-Message-State: AJIora/u2aJyv/d6UEHboS0E8NAHXb//96MZbbRX7OzqTyLedpzIgH1I
        wcJsm496AvHcTK4x9x/HOMV/1bR9nYouZhGa
X-Google-Smtp-Source: AGRyM1smvw0/lAGLTRSGOQGBcrDCSFDeoBWqo/O5+X6eQMzgzTDE49l+m5fOgZcZxJihsRJmZL6v9w==
X-Received: by 2002:a65:6685:0:b0:41a:aea0:c895 with SMTP id b5-20020a656685000000b0041aaea0c895mr17836350pgw.312.1658904288265;
        Tue, 26 Jul 2022 23:44:48 -0700 (PDT)
Received: from localhost ([139.177.225.239])
        by smtp.gmail.com with ESMTPSA id k4-20020a170902ce0400b0016d42244886sm10409406plg.94.2022.07.26.23.44.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 23:44:47 -0700 (PDT)
Date:   Wed, 27 Jul 2022 14:44:44 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, mike.kravetz@oracle.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/5] hugetlbfs: remove unneeded header file
Message-ID: <YuDe3NkOQaFEn77U@FVFYT0MHHV2J.usts.net>
References: <20220726142918.51693-1-linmiaohe@huawei.com>
 <20220726142918.51693-4-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220726142918.51693-4-linmiaohe@huawei.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 26, 2022 at 10:29:16PM +0800, Miaohe Lin wrote:
> The header file signal.h is unneeded now. Remove it.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks.
