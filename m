Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 940B859AD7C
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 13:33:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344978AbiHTLdD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 07:33:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243695AbiHTLdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 07:33:02 -0400
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66B3380483;
        Sat, 20 Aug 2022 04:33:01 -0700 (PDT)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-33387bf0c4aso181332867b3.11;
        Sat, 20 Aug 2022 04:33:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=s4YFkGtdXGzExhgNNdWzDxbHiVYa6fhYdbL1HlHh5fU=;
        b=lPS13Jt9RTHcFpj8TMTDSTuzMOrMRdDaRI3b7EVWXimvXZm5y2akK5KuG5bZNclop/
         aJ/O+GEBp926HDmYEvYPhSHRbdLS65tW+InCwHJg2dEcGE3ToYvuThl6lucbrbj1S4Fx
         WXWAD+cgjis6rqz1RgKLSVye2YB0NP9SMAgmAHN1Er+WfK6crNyFpavt02ZzXm9JF67G
         J33DllFWgpRkOucd55Qm6pykNBL2Wcgc1TuwdYT9Sq1wW08g27Ip9ScfZH+o6LJWEg6z
         UFdCykfZglzY+ScyCESjd6worA3kGa9WEuA7zpnBgqBEGd7MfDnU3w9AxRVlbFLeNRBJ
         J/CQ==
X-Gm-Message-State: ACgBeo0zkdd3N85uHFBAr93IMEJ/pfIzzKe2GY/27E6SaTLiTNqk+QaL
        LJBvfSW7xXGFv7xbVwCaZfFrgt324ktjv7YL5U4=
X-Google-Smtp-Source: AA6agR5Cn9hLu3/OJLOHbF9qDGe+HULcGTi0pu1StW/GqWS7wETiRPmvIBgNCRbC09S0TF4cpuqDw9TMM8vXLNaWxME=
X-Received: by 2002:a0d:cdc2:0:b0:335:debd:2b3d with SMTP id
 p185-20020a0dcdc2000000b00335debd2b3dmr11202523ywd.19.1660995180680; Sat, 20
 Aug 2022 04:33:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220812130645.14710-1-sbinding@opensource.cirrus.com>
 <YvatIg1ywD5EkxTk@paasikivi.fi.intel.com> <YvatSoqXEtI7oqUO@paasikivi.fi.intel.com>
In-Reply-To: <YvatSoqXEtI7oqUO@paasikivi.fi.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sat, 20 Aug 2022 13:32:49 +0200
Message-ID: <CAJZ5v0j0-5YL0ip48NndWKRM7n59ppyjdoye4B5X5m1CrqKFDg@mail.gmail.com>
Subject: Re: [PATCH v1] ACPI: Property: Fix type detection of unified integer
 reading functions
To:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        patches@opensource.cirrus.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 12, 2022 at 9:43 PM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> On Fri, Aug 12, 2022 at 07:42:26PM +0000, Sakari Ailus wrote:
> > Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>

This is still OK if you have reviewed the patch.

> Should have been:
>
> Tested-by: Sakari Ailus <sakari.ailus@linux.intel.com>

Applied as 6.0-rc material, thanks!
