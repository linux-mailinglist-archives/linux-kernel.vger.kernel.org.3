Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F24F4F1709
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 16:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377441AbiDDOfh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 10:35:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349018AbiDDOfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 10:35:34 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7600CB36;
        Mon,  4 Apr 2022 07:33:34 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id p15so20346773ejc.7;
        Mon, 04 Apr 2022 07:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=A6ZKWiB8I5M3lzcB/2FclWNwcHmfaxvPuNrwRz+p3L0=;
        b=DDBYGAa8jgRjFHHIRay7N+XCJqZbhF+ucEYop10+z0gj4BmoSIePmHHqnTGduLv6x8
         88/UDzxtXvDJpoqgPb7SFb7FF2QymMIQL7Z8ftS5kDDbbyg13kP65audUjsi8jAu0kXH
         cp4ffBJU3nSRtaJ8qgDcaHkQkluAUZ2JunmFEXF3slHRgK4c7MQDMeqMycJKOEquGRiq
         1qFaYON7/nmgRQZO0UzE5ORSWmW7EckOjuJ01LHGew4Qdw+PFyWy/qMbgfHTySLkeh7/
         DfoB0m2r2hJXPe27bMOgGmj21e4awfXJOGUuUanrdOK2lhW3nX45E/zMfYgFUzqhby7t
         s2UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=A6ZKWiB8I5M3lzcB/2FclWNwcHmfaxvPuNrwRz+p3L0=;
        b=Ybezob/9xNwPSH6VaTWuMg+VVQ+qBZrhsNM+p4AH0/qDmcstCu+9s/x++EFniyOGiW
         tCqqyA7FyfE+6pAIWu1TBuvZN+wnO+8ZTHKQEPVGbEJ3i3kFO97Bbwa8Q3IcuALBr33L
         2vZDcDiYZXGdxuoonWbJQuH0FlN7bJE0rXR9dvjeT6kBRhWSGZYX3PfAUyDHOIltaMWt
         KpH1Z4i0tn8KmXBJkJj6TaoBan6yT7ERAvUUDNk4lQoTftRtVm9KjFR3rw3YY9Q7Vx3I
         Bxmp3LgcViEvqMK89Pld2QEF5Z309Q2b8XM2j1tsRCCEjirbfs/51IB1KNT1OnUEd3re
         6yhQ==
X-Gm-Message-State: AOAM5310you5mCAo3VDiQ9dUdEYgPK3KrkOdcAe7hLRxUfHTHt1gh0P8
        /crEnCMrvWB+i3LDgvGn01U=
X-Google-Smtp-Source: ABdhPJyV6jFP4PFp0F4ukAS+Pz3sVvHdOiTpHInr1obDz5xfyJi4fNElteCbEWhIBo/NNCZtjj8frw==
X-Received: by 2002:a17:907:6d15:b0:6e7:7c12:b06d with SMTP id sa21-20020a1709076d1500b006e77c12b06dmr347815ejc.594.1649082812812;
        Mon, 04 Apr 2022 07:33:32 -0700 (PDT)
Received: from fedora ([95.180.24.23])
        by smtp.gmail.com with ESMTPSA id sa19-20020a170906edb300b006e7fd5bfd51sm635338ejb.177.2022.04.04.07.33.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 07:33:32 -0700 (PDT)
Date:   Mon, 4 Apr 2022 16:33:30 +0200
From:   Aleksa Savic <savicaleksa83@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-hwmon@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] hwmon: (aquacomputer_d5next) Add support for
 Aquacomputer Octo
Message-ID: <YksBulZ/zU/4aB+N@fedora>
References: <20220404134212.9690-1-savicaleksa83@gmail.com>
 <20220404135707.GA3283128@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220404135707.GA3283128@roeck-us.net>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter,

Thank you!

Aleksa
