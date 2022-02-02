Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B44A64A6A96
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 04:40:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244062AbiBBDko (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 22:40:44 -0500
Received: from mail-oi1-f169.google.com ([209.85.167.169]:46048 "EHLO
        mail-oi1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243770AbiBBDkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 22:40:42 -0500
Received: by mail-oi1-f169.google.com with SMTP id m9so37350911oia.12;
        Tue, 01 Feb 2022 19:40:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=6M/HoWEUP68v359RfQJWkPc7thFvVcT0dU0JkzkDdHE=;
        b=mGA8ZiiUCt/DzKQl6X8vJbpeFALKKYrrdUjwUyNdgfWVMb6FvobDiFLrQzoK9LshP0
         R7WYyQZlv0QYF8DJylxEKKf20TkJJYd3zXQYYVFnF0qMxotdnbu5QWyjnoweDPnfeWGM
         KhGiVBcb9gSlKhfD5nsiHL2m1eaV7E7X8Yhm6n09kU5QiyAs0pq6IIhItMcYlxsKkNWf
         PO4yeC/HkcD/D3gx4B7CXVoyoLiJRIpB+uVPGtmYlJZgPn8fRCdzFhG/SWZLstiGP0QA
         KPwa1+jwmDByDRQulSbpCSJ5znOUCGXpQWcVnFV/eUq5OZNhqtm2rT6ATRVvF+9C+JHQ
         stgg==
X-Gm-Message-State: AOAM53075SsIn76jMO2WlNfu1T4MSgDu5JhRO5ALd7CkvDIobfEH6uln
        gx2cWVqQKKcpldtm4j/xNw==
X-Google-Smtp-Source: ABdhPJxZJ5hzAwugv6TPI/S5uWds3EorF/S9+nvGDzjtLgkzhIj2pDzP4wI2Mlw8TmD8orNaV5ZusQ==
X-Received: by 2002:a05:6808:14c1:: with SMTP id f1mr3424374oiw.129.1643773242362;
        Tue, 01 Feb 2022 19:40:42 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id l19sm10925400ooa.7.2022.02.01.19.40.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 19:40:41 -0800 (PST)
Received: (nullmailer pid 1397926 invoked by uid 1000);
        Wed, 02 Feb 2022 03:40:40 -0000
From:   Rob Herring <robh@kernel.org>
To:     Cristian Pop <cristian.pop@analog.com>
Cc:     devicetree@vger.kernel.org, jic23@kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        robh+dt@kernel.org
In-Reply-To: <20220201162351.53520-1-cristian.pop@analog.com>
References: <20220201162351.53520-1-cristian.pop@analog.com>
Subject: Re: [PATCH v2 1/2] dt:bindings:iio:frequency: Add ADMV4420 doc
Date:   Tue, 01 Feb 2022 21:40:40 -0600
Message-Id: <1643773240.843870.1397925.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 01 Feb 2022 18:23:50 +0200, Cristian Pop wrote:
> Add device tree bindings for the ADMV4420 K band downconverter.
> 
> Signed-off-by: Cristian Pop <cristian.pop@analog.com>
> ---
> changes in v2:
>  - Fix indentation
>  - Remove '|', there is no formatting to persevere
>  - Add plank line before 'properties:'
>  - replace '_' with '-' in property names
>  .../bindings/iio/frequency/adi,admv4420.yaml  | 54 +++++++++++++++++++
>  1 file changed, 54 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/frequency/adi,admv4420.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/iio/frequency/adi,admv4420.yaml:13:5: [warning] wrong indentation: expected 2 but found 4 (indentation)

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/frequency/adi,admv4420.example.dt.yaml: admv4420@0: adi,lo-freq-hz: 'anyOf' conditional failed, one must be fixed:
	16743700000 is greater than the maximum of 4294967295
	From schema: /usr/local/lib/python3.8/dist-packages/dtschema/schemas/property-units.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1587310

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

