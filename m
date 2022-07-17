Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 805525774E4
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 09:11:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232762AbiGQHLV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 03:11:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiGQHLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 03:11:19 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72F0E13FBA
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 00:11:18 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id az2-20020a05600c600200b003a301c985fcso5303048wmb.4
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 00:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QIfm0FyL7ETCgTS1XIcwPOq+ysNEIu2f773xAoF5LhI=;
        b=QcxakoEsSmo6rAY957OFJ6buLha+ywu+71E2c/dJV4kn22CKa5Um+t8C8I3dvDrNpu
         753fQZU7uow5YeP23E6NqjLG+X/WXsdDoww5bLgWIX2MwHYBPoABiOanCUX2/z292nC1
         qSuLegwrhr93FuVaBOkDYukx5n6desG5qe1DM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QIfm0FyL7ETCgTS1XIcwPOq+ysNEIu2f773xAoF5LhI=;
        b=sVUwf7eCP1dkJV08U7MVLISI54R4Kn41LGkZdd+UOQB7Dh8Lf+4pmUnzS6+++u6DLR
         OVRTgXva3zK9KclOBTmumldWBDJ3hxAG4CBGb997tEfsD6rtSoLnCgRN+4EhgAUMnK5Y
         U4XxDgp3L4ps/vxantlEDqbr/TvPu/EOT578kDTqhiFTX5TVh53/IDGmB7cBqrDYXUb8
         PSYbIyMoRyZyLoUjOr38kBBmtn8mQBmljp4lQAoT0R2o1hUvC9rNQFM40b6R0U6nZt4X
         tFni7UhQcxeA30sG0p/DtJl0xNmd6R+Z7INKr+ZBNjFaFVMy6Y6gr4bqhqY4mKexe8T7
         tspg==
X-Gm-Message-State: AJIora/VMM3OxhJqNdH8a1El2JMaMyD9jQl8X9js6ScpwNd3WtL3bBy5
        UpdhdrPyK3Ka7XyqwKG6h9e0fqge0UkgtA==
X-Google-Smtp-Source: AGRyM1sxOXZyZ7k9zLH52vFvi91CLCigsL7LJDzKvajZTIKSUkHGtMAiVjuwEfdwwup/wPGJOw6BDQ==
X-Received: by 2002:a05:600c:a41:b0:39c:1512:98bd with SMTP id c1-20020a05600c0a4100b0039c151298bdmr28084891wmq.88.1658041876849;
        Sun, 17 Jul 2022 00:11:16 -0700 (PDT)
Received: from localhost ([2a01:4b00:8432:8600:5ee4:2aff:fe50:f48d])
        by smtp.gmail.com with ESMTPSA id n30-20020a05600c3b9e00b003a2ed2a40e4sm13637561wms.17.2022.07.17.00.11.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Jul 2022 00:11:16 -0700 (PDT)
Date:   Sun, 17 Jul 2022 08:11:15 +0100
From:   Chris Down <chris@chrisdown.name>
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>
Subject: Re: arch/parisc/math-emu/driver.c:88:17: sparse: sparse: Using plain
 integer as NULL pointer
Message-ID: <YtO2E1+0sMFb+3VO@chrisdown.name>
References: <202207171242.NdWlnOID-lkp@intel.com>
 <YtOwNiF1JJK544bN@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <YtOwNiF1JJK544bN@chrisdown.name>
User-Agent: Mutt/2.2.6 (2022-06-05)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oh, looks like that's already fixed by commit 7f2dcc7371c1 ("parisc: math-emu: 
Avoid "fmt" macro collision"). I don't know why the sparse warning is still 
there then, but moving to _printk certainly fixes it. I'll try to work out why 
before sending the patch to at least give a reasonable changelog.
