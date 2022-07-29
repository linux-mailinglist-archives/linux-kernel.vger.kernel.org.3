Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA84A585633
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 22:35:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239268AbiG2UfC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 16:35:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbiG2UfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 16:35:00 -0400
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED6718B4A3;
        Fri, 29 Jul 2022 13:34:59 -0700 (PDT)
Received: by mail-pg1-f179.google.com with SMTP id f11so4846493pgj.7;
        Fri, 29 Jul 2022 13:34:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=0+bWLHJOx45iiwCJpe5ZJppcA/M8JhlaHbX98hBepDA=;
        b=Axj1SaSqE45x8b9a7bPs0GtxvsWNTqsBlVl+F1h5M4V/LThdJNGaVzqp5yfeOAqM0w
         ReipL+O0f0mdCZLs9bi+Cp91gB+cJoaB8CA/9twqnwP27H/zPtywOfJR7caSeC3sq7DH
         jiRj8yl1AcY6sU5ttKLA+fk+SQ8HKkMeqkqJR427Y8MlN/DpWuIiUcV/Zt+q/xjddgM6
         EeV8rL2v5k2HjM4LJBHINSRoHGu4iI4Cs1K0rLK5rVNS3DK1HnjkgHigYBu02ybelgZt
         tHMC3Js9wqwHIIVGx5AjsvTBlPST8Y02zv1tGH/wyjgz/4+5n7qjWZyKRHV5doLJqKLI
         /1CQ==
X-Gm-Message-State: AJIora/01gmMf8B/4wEtviEMSmCuGvq1J1flf3kyp2hg2UC7QV1LG81k
        lpB7H5RRH0MBBCgg7qJv2Us=
X-Google-Smtp-Source: AGRyM1vUW6m/4O/pOrRyh+8zLyTRhjy/Il6Jq2Oc4GyykIOggl3N53pybs0DnjCyVBO9To2xVqCQlA==
X-Received: by 2002:a63:4521:0:b0:419:a2dc:b3b7 with SMTP id s33-20020a634521000000b00419a2dcb3b7mr4335192pga.578.1659126899475;
        Fri, 29 Jul 2022 13:34:59 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:f090:7a49:3465:6a5? ([2620:15c:211:201:f090:7a49:3465:6a5])
        by smtp.gmail.com with ESMTPSA id l5-20020a635705000000b0041b67615584sm2875983pgb.68.2022.07.29.13.34.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Jul 2022 13:34:58 -0700 (PDT)
Message-ID: <80e6108c-d064-5472-26bd-afde6d0bb93e@acm.org>
Date:   Fri, 29 Jul 2022 13:34:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v5 6/6] scsi: ufs: wb: Move the comment to the right
 position
Content-Language: en-US
To:     j-young.choi@samsung.com, ALIM AKHTAR <alim.akhtar@samsung.com>,
        "avri.altman@wdc.com" <avri.altman@wdc.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220729045756epcms2p40a1baa2c6bf17772023ccec20aef3f0a@epcms2p4>
 <20220729045656epcms2p1e6912ae09ca2122d4d04854878e19b2c@epcms2p1>
 <20220729045600epcms2p45c0f8a5a0a76c7fe85b0961570de89ce@epcms2p4>
 <20220729045433epcms2p77ff2cdde6ddffd9ab0b0810ebe84f0e5@epcms2p7>
 <20220729045252epcms2p7fee5c1cdca5e4bef02a833e40f80649b@epcms2p7>
 <20220729045045epcms2p8caf00317889ed4da8531b7466ec6e368@epcms2p8>
 <CGME20220729045045epcms2p8caf00317889ed4da8531b7466ec6e368@epcms2p5>
 <20220729045913epcms2p598edffb67d42db84526acce0a5a9ce5d@epcms2p5>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220729045913epcms2p598edffb67d42db84526acce0a5a9ce5d@epcms2p5>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/28/22 21:59, Jinyoung CHOI wrote:
> The location of the comment is wrong. so fix it.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
