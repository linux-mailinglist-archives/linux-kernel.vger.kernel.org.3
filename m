Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7563455D362
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:12:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241862AbiF1Alp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 20:41:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241779AbiF1Alm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 20:41:42 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9091CE1E;
        Mon, 27 Jun 2022 17:41:41 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id n16-20020a17090ade9000b001ed15b37424so11015441pjv.3;
        Mon, 27 Jun 2022 17:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=zhoZRzmMKzx2Eo7D6V2F/Yf95Srh3OnFnFprcBLngds=;
        b=BgL/nZfzRNfja9qNd0wxpXI+9/aacrAlvZTxn8VI333hLtqTJk1yBlvh3VjqVHkOwV
         NgvWlDhcDgQDugml+nxeUBu8psKUYKqLDAit6/mvLqboga4TIngt9J/EB6dlKrZNBjmg
         UdSAP8dUUPbwTYvPrkd0Y8MOmL68K29fPv3q13+sAY0vZ0F8Q88Xus0RE+03J6ygkkXu
         LAQxtGHpuXp+gG9dMlVBxHy5woUU2B9H/TCYsit5VKLQ6W2qdTlmVdL4N4ywrknCd3wY
         Z4zpKlqO3UyGA6A4sJ441sy97igLjH/l7akSVwW1yFdV7fS6Trz205BBl+QRoPhEclYo
         2rxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=zhoZRzmMKzx2Eo7D6V2F/Yf95Srh3OnFnFprcBLngds=;
        b=HqGP3nlJqNAU+3g5ANrCbSRD1jxLe6yqCHNElpK048G1v8soHw2lcC1mo6SiLkoYKG
         HdjMKUG7wsMx6y4aTdesAn6nKBTFSosdoD/hevhvcTelECSAxlctCF5BKT02MP/ZXaRW
         OfjUYyMFaon9MdUPEIRp2bJxUE2RGcK20MKpUmc7KHARj6hh2cnzSgN5UV6PV4p9kSRR
         xO1UxOq0gq79jd9YrT6KrxWn/DBDlgbXSvOhH1i+zUEhoMxiJtOhrMvC1k3u/doXOWgw
         5FA/8zvJGBmizqiNmROnXtUykZDAVSBGjx3hZ9AsssOTimLG1RgewJV65dEc8htcaTv1
         QvNA==
X-Gm-Message-State: AJIora/lUCS0W2GLlACi1FxEKWth2Mv0B9kLSfwZAsvme6YqsHNYTZOD
        fOKCyrLIzdDieALa+QfQjck=
X-Google-Smtp-Source: AGRyM1v820UVgTCmg//XKPAHQ5lBONTB/RXJJbnfHOYmsU+U/kAn/8y3MhjvjCu82PPhbLzAnqc2Ew==
X-Received: by 2002:a17:902:ccd0:b0:168:db72:15e with SMTP id z16-20020a170902ccd000b00168db72015emr920597ple.63.1656376901474;
        Mon, 27 Jun 2022 17:41:41 -0700 (PDT)
Received: from [192.168.43.80] (subs28-116-206-12-39.three.co.id. [116.206.12.39])
        by smtp.gmail.com with ESMTPSA id i11-20020a1709026acb00b001640aad2f71sm7806738plt.180.2022.06.27.17.41.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jun 2022 17:41:40 -0700 (PDT)
Message-ID: <8734fe7a-212d-f0e7-686e-1e929dddf1a9@gmail.com>
Date:   Tue, 28 Jun 2022 07:41:37 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] Documentation: tty: add closing double backticks for
 lookahead_buf() prototype
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-doc@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>,
        Jiri Slaby <jirislaby@kernel.org>,
        =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-kernel@vger.kernel.org
References: <20220614164745.7b746354@canb.auug.org.au>
 <20220614091214.511791-1-bagasdotme@gmail.com> <Yrmj14W7eOyuTS94@kroah.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <Yrmj14W7eOyuTS94@kroah.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/27/22 19:34, Greg Kroah-Hartman wrote:
> Ilpo's patch was sent before yours, so I took theirs, sorry.
> 

Ah! I don't see his patch before submitting mine. Thanks anyway for
reminding me.

-- 
An old man doll... just what I always wanted! - Clara
