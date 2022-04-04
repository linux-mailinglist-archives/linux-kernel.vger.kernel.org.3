Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A65DA4F160B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 15:38:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355247AbiDDNkp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 09:40:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233642AbiDDNko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 09:40:44 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48CAFD97;
        Mon,  4 Apr 2022 06:38:48 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id i27so12884597ejd.9;
        Mon, 04 Apr 2022 06:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lZuQSvWpuEhqF9Q2oc7DYxCPnGfDDnh9JDpmMtRFw6g=;
        b=kUW+nUr64jYk2CvdzFvFdJR44F+7XDBcso7Vu2CLB8/98zsOjKM+eBI9EQwQeG+tkf
         K8opM7PdFR7JDUWd7PJbcRDXWQuTsg0pBuCvcum++5r/68YcZ++Xl+0G0ERGIO1O9+m8
         6i0N1EOiiaRI9EZRH5xAxoFhTLB4cTeDJgZuXb4hBn7Je+PbGIHYRnHkT0c2ddM+8tuj
         BprzQ5rhgUpz1neP7I1pNSIU0aTlBHTYo0jQB7GR7xV1Tr5tXDiMnZ31KJCz27FuzgsL
         HraBP1qrAq+iTb5UbR63CSQd/vAmBQbfhKHG0Relrj8XX4d+1LvxsdON20bdS8LuihW9
         S1zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lZuQSvWpuEhqF9Q2oc7DYxCPnGfDDnh9JDpmMtRFw6g=;
        b=EepCBCVi5G/o0wTgyF1/bpFLfTGJVptyb1fRSlomfCr1V7lUWT51yICnes0xlhbjIP
         Dai+IrJAz8OnbdPf1EKKhgTdqL8ykFyfxK3kMmxglU0wR0+/2jPGfFWynYskNO0HXBb1
         DKw4v/gqCBTJs2x9DCYbFNWO9YxP19LU6DzX3FryQTJBLzv8cFykavXPuACxGv6rx3i+
         jbBZQdRHXwGtCTLHSJfEsaLv7UPGXIdVTuQCNpW4uGgrVn77uZIucCc/SxCTgW8ErKUD
         rWY9naMVyWW8C4tQcBbBGRwwnD/CKn1KaCu1N/UmTQ48t1IOhRF2uTMb55rOER/o1LY/
         Bv6g==
X-Gm-Message-State: AOAM530kQ12vK1qT/xyU/PFzSKRdr5H5RTHPQ9Qr/HlnDz8biFl3G03N
        0je0VZLgd/BZkYwh5gmu4Pg=
X-Google-Smtp-Source: ABdhPJx3r6oIHNQ+fuNTjHS7fZHrBDQmlesvO5LGCpk0xTMl8yUx5U1bOREGYdn1BzP5+bs7D3xV4A==
X-Received: by 2002:a17:907:1c95:b0:6e0:8b3e:3a30 with SMTP id nb21-20020a1709071c9500b006e08b3e3a30mr36559ejc.271.1649079526902;
        Mon, 04 Apr 2022 06:38:46 -0700 (PDT)
Received: from fedora ([95.180.24.23])
        by smtp.gmail.com with ESMTPSA id lb4-20020a170907784400b006e0d13f65e5sm4388105ejc.167.2022.04.04.06.38.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 06:38:46 -0700 (PDT)
Date:   Mon, 4 Apr 2022 15:38:44 +0200
From:   Aleksa Savic <savicaleksa83@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-hwmon@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] hwmon: (aquacomputer_d5next) Add support for
 Aquacomputer Octo
Message-ID: <Ykr05NdL28etg2mr@fedora>
References: <20220327070446.8151-1-savicaleksa83@gmail.com>
 <20220403214142.GA2965233@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220403214142.GA2965233@roeck-us.net>
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

Sorry, I didn't get from your previous message that you wanted me to
note it. Will send a v4.

Thanks,
Aleksa
