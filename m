Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B886D4F0F58
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 08:26:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357400AbiDDG2X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 02:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377537AbiDDG2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 02:28:16 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FCD817ABF
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 23:26:21 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id s14-20020a17090a880e00b001caaf6d3dd1so270222pjn.3
        for <linux-kernel@vger.kernel.org>; Sun, 03 Apr 2022 23:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KPWZKT7rXbxTEd/WteLFqRFnq+3UMovg6ND4Ll5auQE=;
        b=ArE7uCB4oI7KA/Xm0VWivXvesffRt5PfmkswBMybP8XGWfZ+IUf8+UemrsSrrjs0pZ
         vM3NL+Jjbaca4eCqdHvLCdLgS5/SI/pNV7mx9L6h5JxPbL8eEKThL7es0w75hOFyvFJO
         uNQyWvkr2xFnKz5BV5vmDKkw9y8cc63mXOvHl51yZnbITJqHhCQCnRNijw0ZkNlqhmrj
         XHbdLB0HHlZ1PXUgchSh7z4Q897BWWl91z+x8g2M0lN8HrmZExZbEEi5V0m/qMYoLmPe
         A/Ggl7B+eZt6odteT/2UtZk5C78j7vDrQ7itYJCxgZku1XKWGWcg3iCeLK3pqZ2fhWJN
         8SdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KPWZKT7rXbxTEd/WteLFqRFnq+3UMovg6ND4Ll5auQE=;
        b=S8yGmspdSEh3Xnynx0mX0Hx3+70Vni7ya30SIKKS5nDcSE6P/0mAR99DAsasreUzJ9
         yC6pPYgeVg0J4nswjTQWwdFaHeCYA+g3U5ThcadfQyfVveMDJuNjbAL3b/RXRjR1ajI8
         N/OqateoywUthl/yVWXiz9cGE2H2DRfhSHdOIFXwXdGoMmrUWrrZ5mzcycp5nwXUMtL2
         8wo9o+cK75B/A2aC6KtqUps7xOhapQbA4neotuaCDB2LiazY/gP+V8VOY0gLJ93er1aF
         K6QX9T0v9krTvxnhaEdi0hh9hJV9HcOR8I9k0skPQSzL83Cit5x4WZdh0JmqrUPslYcH
         J+/Q==
X-Gm-Message-State: AOAM533y9QOSyOXKRe3tqBoH+1vrBxYd9H+jn7YvTwPKA5YNdlWhd2Yi
        7oeBFXJxguZV3yBmxbNp/A33zQ==
X-Google-Smtp-Source: ABdhPJz6cI5D7xsRDpGQlH79Z1TQVxkxjBug0u1YG+hYqnUYnZnstMAOSG3iJoZYFOpJhIneFEDZCw==
X-Received: by 2002:a17:90b:3ecb:b0:1c7:74f6:ae73 with SMTP id rm11-20020a17090b3ecb00b001c774f6ae73mr24746094pjb.236.1649053580563;
        Sun, 03 Apr 2022 23:26:20 -0700 (PDT)
Received: from localhost ([223.184.83.228])
        by smtp.gmail.com with ESMTPSA id x14-20020aa784ce000000b004fa79973c94sm10250228pfn.165.2022.04.03.23.26.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Apr 2022 23:26:19 -0700 (PDT)
Date:   Mon, 4 Apr 2022 11:56:18 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PM: opp: Fix NULL pointer exception on a v2 table
 combined with v1 opps
Message-ID: <20220404062618.jtqlb4cfkerctpas@vireshk-i7>
References: <20220401120325.820763-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220401120325.820763-1-krzysztof.kozlowski@linaro.org>
User-Agent: NeoMutt/20180716-391-311a52
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01-04-22, 14:03, Krzysztof Kozlowski wrote:
> dev_pm_opp_add() adds a v1 OPP.  If the Devicetree contains an OPP v2
> table with required-opps, but the driver uses dev_pm_opp_add(), the
> table might have required_opp_count!=0 but the opp->required_opps will
> be NULL.

This use-case isn't supported currently, as either all OPPs should
have required-opp or none. This kind of scenario may end up breaking
at other places later on, as I have designed this stuff with the
above assumption.

-- 
viresh
