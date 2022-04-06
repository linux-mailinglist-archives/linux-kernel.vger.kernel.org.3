Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3BCE4F6A3E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 21:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231614AbiDFTq5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 15:46:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232556AbiDFTq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 15:46:28 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EAFD12B5E0;
        Wed,  6 Apr 2022 10:27:57 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id i27so5693396ejd.9;
        Wed, 06 Apr 2022 10:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :content-transfer-encoding:user-agent:mime-version;
        bh=xxCKDvKnzlNmqyD52b0jxmYNrkhxIBtLbpCHK1k0Wm4=;
        b=Go6jjY9HwVfN8849F/tu3wLhHCF2+be7CREncdaWcwWytkGDGtl/+gL5l+SeEVopv0
         mmwdwL7xUZ+F48FleaVc8S3vVCLkO7sNQcY1YiMatQdpTq54DRmEuyhosLl7KnabRVev
         tdwQsxzVm2jBHpqDxzca1hEBjsCY6ogdUMsc0x9xw6MhzfENSTllPkCoy79P5UelDYy2
         yPztHGAh430TzrnVSj2MhGghMtcZ5Ft8pt9QwHi8fakodQdm782zk+cQffOF41U2rzRU
         25h9BWMNonR0QCZ0uYtxnT5vlDvj4orkArsiAQRShuonVk4y0rdfD5fn0skc9Qx5NyUr
         4wyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-transfer-encoding:user-agent:mime-version;
        bh=xxCKDvKnzlNmqyD52b0jxmYNrkhxIBtLbpCHK1k0Wm4=;
        b=p5kLKQKpj2rxj+WhUgumcy5LQJ9gPHiINgtkfLhPS8HnxDOw6pGSVYGvWjyRwAy6nf
         RyFIlyp/V/YoksyqjnRO8mr8hi2DuPgvIOXHVI5HttumDckfLGCUZW7d4vDWXsrorpuK
         duaSpeesMCkmc4zqKoIf6G8hpeOLYMrY9RyC7OupL8laW39uzWWEn4W5B5SleBwy8/tX
         TlOOmQHq1s83pdJFh4XzsypnrFMiLJUf6VBRtwCBIPXGqmrRCG3qISVU0LaTWVwVS9cZ
         Qq+6khCXMy07zPZXWlmtJvjG+k3s6g5WTaSKpe41i9vlDgScSr4+sIVOJ10dCYZlC3g2
         HUdA==
X-Gm-Message-State: AOAM532ciNAUyapkT/IUliDHBifkT9tgKSrgtjARh/0IAbMzKkwGuX6u
        VmbC5sOpq9odyHTnHGkVHbnMzUn3Y/k=
X-Google-Smtp-Source: ABdhPJx8WufAEKheFrGyDVjFFwqIVn7YLi7ZNhhs0FTnMcKuGlnpHHFX5oHQnsi8jJiAJ08+Gk6OHw==
X-Received: by 2002:a17:906:acf:b0:6e7:681e:b4b6 with SMTP id z15-20020a1709060acf00b006e7681eb4b6mr9552820ejf.61.1649266075691;
        Wed, 06 Apr 2022 10:27:55 -0700 (PDT)
Received: from [192.168.3.2] (p5dd1ed70.dip0.t-ipconnect.de. [93.209.237.112])
        by smtp.googlemail.com with ESMTPSA id j8-20020aa7c0c8000000b0041934547989sm8273597edp.55.2022.04.06.10.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 10:27:55 -0700 (PDT)
Message-ID: <c1350e15546652aedf2b9f0c1cf207a950afbeb7.camel@gmail.com>
Subject: Re: [PATCH  v2 0/4] rpmb subsystem, uapi and virtio-rpmb driver
From:   Bean Huo <huobean@gmail.com>
To:     Alex =?ISO-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc:     linux-kernel@vger.kernel.org, maxim.uvarov@linaro.org,
        joakim.bech@linaro.org, ulf.hansson@linaro.org,
        ilias.apalodimas@linaro.org, arnd@linaro.org,
        ruchika.gupta@linaro.org, tomas.winkler@intel.com,
        yang.huang@intel.com, bing.zhu@intel.com,
        Matti.Moell@opensynergy.com, hmo@opensynergy.com,
        linux-mmc@vger.kernel.org, linux-scsi@vger.kernel.org
Date:   Wed, 06 Apr 2022 19:27:53 +0200
In-Reply-To: <87ee2ajuky.fsf@linaro.org>
References: <20220405093759.1126835-1-alex.bennee@linaro.org>
         <8b3ce88f65fd11523a4d2daab3c617f7089eb1ce.camel@gmail.com>
         <87r16bk013.fsf@linaro.org>
         <aeb64d1c4bbddfd8463c07a40ab1fc78be0d158d.camel@gmail.com>
         <87ee2ajuky.fsf@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.0-1 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>=20
> Can you point be to where the UFS driver does it's current RPMB
> stuff?
>=20

If you want to understand the UFS RPMB functionality/command sequence,
you can refer to the ufs-utils tool, it is much like mmc-utils.

https://github.com/westerndigitalcorporation/ufs-utils/blob/dev/ufs_rpmb.c

> >=20
> > Kind regards,
> > Bean
>=20
>=20

