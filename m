Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF6950866D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 12:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377841AbiDTK4x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 06:56:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344742AbiDTK4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 06:56:50 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98694403F0;
        Wed, 20 Apr 2022 03:54:04 -0700 (PDT)
Received: from fraeml742-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KjyB56Bxnz6F9Dq;
        Wed, 20 Apr 2022 18:50:21 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml742-chm.china.huawei.com (10.206.15.223) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 20 Apr 2022 12:54:02 +0200
Received: from localhost (10.202.226.41) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 20 Apr
 2022 11:54:01 +0100
Date:   Wed, 20 Apr 2022 11:54:00 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Rokosov Dmitry Dmitrievich <DDRokosov@sberdevices.ru>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "stano.jakubek@gmail.com" <stano.jakubek@gmail.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "stephan@gerhold.net" <stephan@gerhold.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        kernel <kernel@sberdevices.ru>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 2/3] iio: add MEMSensing MSA311 3-axis accelerometer
 driver
Message-ID: <20220420115400.00005c48@Huawei.com>
In-Reply-To: <20220419154555.24191-3-ddrokosov@sberdevices.ru>
References: <20220419154555.24191-1-ddrokosov@sberdevices.ru>
        <20220419154555.24191-3-ddrokosov@sberdevices.ru>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.41]
X-ClientProxiedBy: lhreml717-chm.china.huawei.com (10.201.108.68) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Apr 2022 15:45:55 +0000
Rokosov Dmitry Dmitrievich <DDRokosov@sberdevices.ru> wrote:

> MSA311 is a tri-axial, low-g accelerometer with I2C digital output for
> sensitivity consumer applications. It has dynamical user selectable full
> scales range of +-2g/+-4g/+-8g/+-16g and allows acceleration measurements
> with output data rates from 1Hz to 1000Hz.
> 
> This driver supports following MSA311 features:
>     - IIO interface
>     - Different power modes: NORMAL, SUSPEND and LOW (using pm_runtime)
>     - ODR (Output Data Rate) selection
>     - Scale and samp_freq selection
>     - IIO triggered buffer, IIO reg access
>     - NEW_DATA interrupt + trigger
> 
> Below features to be done:
>     - Motion Events: ACTIVE, TAP, ORIENT, FREEFALL
> 

Forgot to mention. Please add a Datasheet: tag to this patch as it's
the one introducing the actual driver.

> Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
